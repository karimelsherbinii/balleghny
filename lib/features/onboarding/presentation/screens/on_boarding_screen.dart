import 'package:ballaghny/config/routes/app_routes.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/default_button.dart';
import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/assets_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        pageIndex = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var translator = AppLocalizations.of(context)!;
    bool isCurrentPage(int index) => pageIndex == index;
    List<Map<String, dynamic>> splashPages = [
      {
        'image': AppAssets.onBoardingOne,
        'title': translator.translate('onBoardingOneTitle'),
        'description': translator.translate('onBoardingOneDescription')!,
      },
      {
        'image': AppAssets.onBoardingTwo,
        'title': translator.translate('onBoardingTwoTitle'),
        'description': translator.translate('onBoardingTwoDescription')!,
      },
      {
        'image': AppAssets.onBoardingThree,
        'title': translator.translate('onBoardingThreeTitle'),
        'description': translator.translate('onBoardingThreeDescription')!,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: context.width * 0.3,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:
                          isCurrentPage(0)
                              ? HexColor('#ED6A24')
                              : AppColors.primaryColor,
                    ),
                  ),
                  Container(
                    width: context.width * 0.3,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:
                          isCurrentPage(1)
                              ? HexColor('#ED6A24')
                              : AppColors.primaryColor,
                    ),
                  ),
                  Container(
                    width: context.width * 0.3,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:
                          isCurrentPage(2)
                              ? HexColor('#ED6A24')
                              : AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              flex: 3,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: PageView.builder(
                  itemCount: splashPages.length,
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            splashPages[index]['title'],
                            key: Key('onboarding_step${index + 1}_title'),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            splashPages[index]['image'],
                            width: context.width * 0.8,
                            height: context.height * 0.6,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            splashPages[index]['description'],
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultButton(
                      key: const Key('onboarding_next_button'),
                      margin: 5,
                      btnLbl: translator.translate('start_now')!,
                      onPressed: () {
                        if (pageIndex < splashPages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.loginRoute,
                            (route) => false,
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: DefaultButton(
                      margin: 5,
                      isOutlined: true,
                      btnLbl: translator.translate('skip')!,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.loginRoute,
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
