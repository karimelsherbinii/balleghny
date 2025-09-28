import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/utils/hex_color.dart';

class EmergenceWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String relationship;
  final Function()? onDeleteTap;
  final Function()? onEditTap;
  const EmergenceWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.relationship,
    this.onDeleteTap,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: onDeleteTap,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                ),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 16,
                    color: HexColor('9E9E9E'),
                  ),
                ),
                Text(
                  relationship,
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
              child: InkWell(
                  onTap: onEditTap,
                  child: Icon(Icons.edit, color: AppColors.hintColor)))
        ],
      ),
    );
  }
}
