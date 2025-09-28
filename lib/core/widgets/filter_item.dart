import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../entities/category.dart';

class FilterItem extends StatelessWidget {
  final VoidCallback onTap;
  final Category category;
  const FilterItem({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Container(
          width: 90,
          margin: const EdgeInsetsDirectional.only(end: 4),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color:
                  category.isSelected! ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: category.isSelected!
                      ? AppColors.primaryColor
                      : const Color(0xff7C908C))),
          child: Text(
            category.name!,
            style: TextStyle(
                color: category.isSelected!
                    ? Colors.white
                    : const Color(0xff7C908C),
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ));
  }
}
