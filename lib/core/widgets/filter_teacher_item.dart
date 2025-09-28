import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../entities/instructor.dart';

class FilterTeacherItem extends StatelessWidget {
  final Insructor insructor;
  final VoidCallback onTap;
  const FilterTeacherItem(
      {super.key, required this.insructor, required this.onTap});

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
                insructor.fullName!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              insructor.isSelected!
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
