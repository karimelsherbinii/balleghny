import 'dart:developer';

import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/widgets/default_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class IntroductionDetailsScreen extends StatefulWidget {
  final String? url;
  final String? title;
  const IntroductionDetailsScreen({super.key, this.url, this.title});

  @override
  State<IntroductionDetailsScreen> createState() =>
      _IntroductionDetailsScreenState();
}

class _IntroductionDetailsScreenState extends State<IntroductionDetailsScreen> {
  _getPages() async {
    // BlocProvider.of<PlansCubit>(context).clearData();
    // await BlocProvider.of<PlansCubit>(context).getPages().then(
    //     (value) => log(BlocProvider.of<PlansCubit>(context).pages.toString()));
  }

  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _getPages();

    // #docregion platform_features
    webViewConfig();
  }

  void webViewConfig() {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url!)) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url!));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.title!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: DefaultBackButton(),
        ),
      ),
      body: SafeArea(
          child: WebViewWidget(
        controller: _webViewController,
      )
          // BlocBuilder<PlansCubit, PlansState>(
          //   builder: (context, state) {
          //     if (state is GetPagesLoadedState) {
          //       return WebViewWidget(
          //         controller: _webViewController,
          //       );
          //     } else if (state is GetPagesLoadingState) {
          //       return const LoadingIndicator();
          //     } else if (state is GetPagesErrorState) {
          //       return Center(
          //         child: Text(state.message),
          //       );
          //     } else {
          //       return const LoadingIndicator();
          //     }
          //   },
          // ),
          ),
    );
  }
}
