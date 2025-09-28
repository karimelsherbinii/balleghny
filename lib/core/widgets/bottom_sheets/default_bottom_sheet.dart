import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/customization_button.dart';

showDefaultBottomSheet(
  BuildContext context, {
  required String title,
  required Widget child,
  final double? maxHeight,
  double? buttonWidth,
  double? buttonHeight,
  final double? maxContainerheight,
  String? buttonText,
  void Function()? onSaved,
  bool withSaveButton = false,
  bool isLoading = false,
}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? context.height * 0.9,
        // minHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder: (contex) {
        // wrapped with the singleChildScrollView to avoid overflow in landscaped mode
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: context.width,
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      // to solve keyboard overlay over the textField
                      padding: MediaQuery.of(context).viewInsets,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  // width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        // color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: AppColors.borderColor,
                                      child: Icon(
                                        Icons.close,
                                        // color: AppColors.primaryColor,
                                        size: 20,
                                      ),
                                    )),
                                //
                              ],
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: maxContainerheight ?? double.infinity,
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.1,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              // physics: const BouncingScrollPhysics(),
                              child: child,
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          if (withSaveButton)
                            CustomizedButton(
                                isLoading: isLoading,
                                haveWidth: true,
                                width: buttonWidth ?? context.width,
                                height: buttonHeight,
                                btnLbl: buttonText ?? 'ارسال',
                                onPressed: onSaved ?? () {}),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                        ],
                      ))),
            );
          },
        );
      });
}
