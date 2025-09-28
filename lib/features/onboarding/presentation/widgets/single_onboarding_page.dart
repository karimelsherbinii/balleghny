import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';

class OnboardingSinglePage extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  const OnboardingSinglePage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  @override
  State<StatefulWidget> createState() => _OnboardingSinglePageState();
}

class _OnboardingSinglePageState extends State<OnboardingSinglePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          widget.image,
          width: context.width,
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: AppColors.primaryColor))),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}
