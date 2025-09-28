import 'dart:developer';

import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/bottom_sheets/default_bottom_sheet.dart';
import 'package:ballaghny/core/widgets/error_widget.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/features/islam/presentation/cubit/islam_cubit.dart';
import 'package:ballaghny/features/islam/presentation/screens/introduction_details_screen.dart';
import 'package:ballaghny/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class IntroductionToIslamScreen extends StatefulWidget {
  const IntroductionToIslamScreen({super.key});

  @override
  State<IntroductionToIslamScreen> createState() =>
      _IntroductionToIslamScreenState();
}

class _IntroductionToIslamScreenState extends State<IntroductionToIslamScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final List<GlobalKey> _shareButtonKeys = [];

  _getDefinitions() {
    BlocProvider.of<IslamCubit>(context).getIntroductions();
  }

  @override
  void initState() {
    super.initState();
    _getDefinitions();
  }

  _searchIn() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<IslamCubit>(
        context,
      ).getIntroductions(search: _searchController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    var translator = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.homeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: NeverScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                DefaultAppBar(
                  title: translator.translate('introduction_to_islam')!,
                  actionIcon: Icon(Icons.language),
                  onActionTap: () {
                    showDefaultBottomSheet(
                      context,
                      title: translator.translate('content_language')!,
                      child: BlocBuilder<LocaleCubit, LocaleState>(
                        builder: (context, state) {
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: Text(
                                  translator.translate('arabic')!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        context
                                                    .read<LocaleCubit>()
                                                    .state
                                                    .locale ==
                                                Locale('ar')
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                leading: Radio(
                                  value:
                                      context
                                                  .read<LocaleCubit>()
                                                  .state
                                                  .locale ==
                                              Locale('ar')
                                          ? 1
                                          : 0,
                                  groupValue: 1,
                                  onChanged: (value) {
                                    debugPrint(value.toString());
                                  },
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<LocaleCubit>().changeLang('ar');
                                },
                              ),
                              ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.translate('english')!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        context
                                                    .read<LocaleCubit>()
                                                    .state
                                                    .locale ==
                                                Locale('en')
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                leading: Radio(
                                  value:
                                      context
                                                  .read<LocaleCubit>()
                                                  .state
                                                  .locale ==
                                              Locale('en')
                                          ? 1
                                          : 0,
                                  groupValue: 1,
                                  onChanged: (value) {
                                    debugPrint(value.toString());
                                  },
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<LocaleCubit>().changeLang('en');
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                // Search field
                DefaultTextFormField(
                  controller: _searchController,
                  hintTxt: translator.translate('search')!,
                  suffixIcon: Icon(Icons.search),
                  textInputAction: TextInputAction.search,
                  onChangedFunction: (p0) {
                    _searchIn();
                  },
                  onFieldSubmitted: (value) => _searchIn(),
                ),
                const SizedBox(height: 20),
                // List items
                buildItems(translator),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItems(translator) {
    return BlocBuilder<IslamCubit, IslamState>(
      builder: (context, state) {
        if (state is GetIntroductionsLoadingState) {
          return LoadingIndicator();
        }
        if (state is GetIntroductionsErrorState) {
          return DefaultErrorWidget(
            msg: state.message,
            onRetryPressed: _getDefinitions,
          );
        }
        log(
          context.read<IslamCubit>().definitions.length.toString(),
          name: 'def counts',
        );

        // Reset the keys list
        _shareButtonKeys.clear();
        for (
          var i = 0;
          i < context.read<IslamCubit>().definitions.length;
          i++
        ) {
          _shareButtonKeys.add(GlobalKey());
        }

        return SizedBox(
          height: context.height,
          child: ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: context.read<IslamCubit>().definitions.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Constants.openUrl(
                  //     context.read<IslamCubit>().definitions[index].url ?? '');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => IntroductionDetailsScreen(
                            url:
                                context
                                    .read<IslamCubit>()
                                    .definitions[index]
                                    .url ??
                                '',
                            title:
                                context
                                    .read<IslamCubit>()
                                    .definitions[index]
                                    .title ??
                                '',
                          ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: HexColor('#ECF0F3')),
                  ),
                  child: Row(
                    children: [
                      // Item Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          imageUrl:
                              context
                                  .read<IslamCubit>()
                                  .definitions[index]
                                  .fullPathImage ??
                              '',
                          placeholder:
                              (context, url) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Icon(
                                Icons.image,
                                color: AppColors.primaryColor,
                                size: 50,
                              ),
                        ),
                        // Image.network(
                        //   context
                        //           .read<IslamCubit>()
                        //           .definitions[index]
                        //           .fullPathImage ??
                        //       '',
                        //   width: 60,
                        //   height: 60,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      const SizedBox(width: 12),
                      // Item Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context
                                      .read<IslamCubit>()
                                      .definitions[index]
                                      .title ??
                                  '',
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Text(
                            //   context
                            //           .read<IslamCubit>()
                            //           .definitions[index]
                            //           .author ??
                            //       '',
                            //   style: TextStyle(
                            //       color: Colors.grey[600],
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w400),
                            // ),
                            // const SizedBox(height: 4),
                            Text(
                              context
                                      .read<IslamCubit>()
                                      .definitions[index]
                                      .humansDate ??
                                  '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${translator.translate('share_count')}: ${context.read<IslamCubit>().definitions[index].shares ?? 0}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Share Icon
                      IconButton(
                        key: _shareButtonKeys[index],
                        onPressed: () {
                          final RenderBox? box =
                              _shareButtonKeys[index].currentContext
                                      ?.findRenderObject()
                                  as RenderBox?;
                          final Rect? sharePositionOrigin =
                              box != null
                                  ? box.localToGlobal(Offset.zero) & box.size
                                  : null;

                          Share.share(
                            context.read<IslamCubit>().definitions[index].url ??
                                '',
                            sharePositionOrigin: sharePositionOrigin,
                          ).then((value) {
                            _getDefinitions();
                          });
                          context.read<IslamCubit>().shareDefinition(
                            context.read<IslamCubit>().definitions[index].id ??
                                0,
                          );
                        },
                        icon: Icon(Icons.share, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
