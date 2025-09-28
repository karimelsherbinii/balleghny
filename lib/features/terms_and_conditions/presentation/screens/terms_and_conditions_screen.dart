import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/features/terms_and_conditions/presentation/cubit/terms_and_conditions_cubit.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/screen_container.dart';
import '../../../../core/widgets/error_widget.dart' as error_widget;

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  _getTermsAndConditions() =>
      BlocProvider.of<TermsAndConditionsCubit>(context).getTermsAndConditions();

  @override
  void initState() {
    super.initState();
    _getTermsAndConditions();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<TermsAndConditionsCubit, TermsAndConditionsState>(
      builder: (context, state) {
        if (state is TermsAndConditionstIsLoading) {
          return const LoadingIndicator();
        } else if (state is TermsAndConditionsError) {
          return error_widget.DefaultErrorWidget(
              msg: state.message!,
              onRetryPressed: () => _getTermsAndConditions());
        } else if (state is TermsAndConditionsLoaded) {
          return RefreshIndicator(
              onRefresh: () => _getTermsAndConditions(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset(AppAssets.logo)),
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
          AppLocalizations.of(context)!.translate('terms_and_conditions')!,
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
