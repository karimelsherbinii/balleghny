import 'package:flutter/material.dart';
import 'package:ballaghny/core/entities/courses.dart';
import '../../../../core/utils/app_colors.dart';

class FilterCoursesItem extends StatelessWidget {
  final Courses courses;
  final VoidCallback onTap;
  const FilterCoursesItem(
      {super.key, required this.courses, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.white,
        onTap: () => onTap(),
        child: SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                courses.title!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              courses.isSelected!
                  ? Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  : Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: const Color(0xff7C908C))),
                    )
            ],
          ),
        ));
  }
}
