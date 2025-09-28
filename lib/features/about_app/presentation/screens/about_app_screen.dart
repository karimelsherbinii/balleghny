import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/widgets/error_widget.dart';
import 'package:ballaghny/features/about_app/presentation/cubit/about_app_cubit.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/screen_container.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  _getAboutAppContent() =>
      BlocProvider.of<AboutAppCubit>(context).getContentOfAboutApp();

  @override
  void initState() {
    super.initState();
    _getAboutAppContent();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<AboutAppCubit, AboutAppState>(
      builder: (context, state) {
        if (state is AboutAppContentIsLoading) {
          return const LoadingIndicator();
        } else if (state is AboutAppError) {
          return DefaultErrorWidget(
              msg: state.message!, onRetryPressed: () => _getAboutAppContent());
        } else if (state is AboutAppContentLoaded) {
          return RefreshIndicator(
              onRefresh: () => _getAboutAppContent(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(AppAssets.logo),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: HtmlWidget(
                        state.content,
                        textStyle: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              ));
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate('about_app')!,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
        ));
    return ScreenContainer(
        child: Scaffold(appBar: appBar, body: _buildBodyContent()));
  }
}
