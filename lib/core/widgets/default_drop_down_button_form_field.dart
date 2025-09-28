import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/hex_color.dart';
import '../utils/app_colors.dart';

// ignore: must_be_immutable
class DefaultDropdownButtonFormField extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic value;
  final String? hintTxt;
  final String? Function(dynamic)? validationFunction;
  final Function(dynamic)? onChangedFunction;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? icon;
  final Widget? prefix;
  final Widget? prefixIcon;
  String title = 'العنوان';
  final String? labelTxt;
  final bool isExpanded;
  final AutovalidateMode autovalidateMode;
  final Color? unfocusColor;
  final Color? hintColor;
  final Color? filledColor;
  final bool filled;
  bool withTitle = false;
  final Function()? onTap;
  DefaultDropdownButtonFormField({
    super.key,
    required this.items,
    this.value,
    this.icon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.hintTxt,
    this.validationFunction,
    this.onChangedFunction,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.labelTxt,
    this.isExpanded = true,
    this.unfocusColor,
    this.hintColor,
    this.filled = true,
    this.filledColor,
    this.onTap,
  });

  DefaultDropdownButtonFormField.withTitle({
    super.key,
    required this.items,
    this.value,
    this.icon,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.hintTxt,
    this.validationFunction,
    this.onChangedFunction,
    required this.title,
    this.suffix,
    this.suffixIcon,
    this.prefix,
    this.prefixIcon,
    this.labelTxt,
    this.isExpanded = true,
    this.unfocusColor,
    this.hintColor,
    this.filled = true,
    this.filledColor,
    this.withTitle = true,
    this.onTap,
  });

  @override
  State<DefaultDropdownButtonFormField> createState() =>
      _DefaultDropdownButtonFormFieldState();
}

class _DefaultDropdownButtonFormFieldState
    extends State<DefaultDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.withTitle ? 5.0 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.withTitle
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.3, vertical: 0.3),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: AppColors.dropMenuTitleColor, fontSize: 14),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: widget.withTitle ? 0 : 16,
            ),
            child: DropdownButtonFormField(
              onTap: widget.onTap,
              autovalidateMode: widget.autovalidateMode,
              icon: widget.icon ??
                  Icon(
                    Icons.arrow_drop_down,
                    size: 20,
                    color: widget.withTitle
                        ? HexColor('#5F6368')
                        : AppColors.hintColor,
                  ),
              style: Theme.of(context).textTheme.labelSmall,
              value: widget.value,
              isExpanded: widget.isExpanded,
              decoration: InputDecoration(
                filled: widget.filled ? true : false,
                fillColor: widget.filledColor ?? Colors.white,
                suffix: widget.suffix,
                suffixIcon: widget.suffixIcon,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                prefix: widget.prefix,
                prefixIcon: widget.prefixIcon,
                hintText: widget.hintTxt,
                labelText: widget.labelTxt,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('F5F5F5')),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('F5F5F5')),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onChanged: widget.onChangedFunction,
              items: widget.items,
              validator: widget.validationFunction,
            ),
          ),
        ],
      ),
    );
  }
}
