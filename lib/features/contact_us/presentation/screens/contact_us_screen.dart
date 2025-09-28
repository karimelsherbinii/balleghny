import 'package:ballaghny/core/utils/assets_manager.dart';
import 'package:ballaghny/core/utils/constants.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:ballaghny/core/widgets/appbar/default_appbar.dart';
import 'package:ballaghny/core/widgets/default_list_tile.dart';
import 'package:ballaghny/core/widgets/loading_indicator.dart';
import 'package:ballaghny/features/contact_us/presentation/cubit/contact_us_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/app_colors.dart';
import 'package:ballaghny/core/widgets/default_text_form_field/default_text_form_field.dart';
import 'package:ballaghny/core/widgets/default_button.dart';
import 'package:ballaghny/config/locale/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var translator = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        height: context.height,
        decoration: BoxDecoration(gradient: AppColors.linearGradient),
        child: BlocBuilder<ContactUsCubit, ContactUsState>(
          builder: (context, state) {
            if (state is ContactUsLoadingState) {
              return LoadingIndicator();
            }
            if (state is ContactUsSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Constants.showToast(message: state.message);
                Navigator.pop(context);
              });
            }
            if (state is ContactUsErrorState) {
              Constants.showError(context, state.message);
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    DefaultAppBar(
                      title: translator.translate('contact_us')!,
                      onActionTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    //facebook
                    InformationListTile(
                      title: translator.translate('facebook')!,
                      icon: AppAssets.facebook,
                      onTap: () {
                        Constants.openUrl('https://www.facebook.com/BadeeaIC');
                      },
                    ),
                    //snapchat
                    InformationListTile(
                      title: translator.translate('snapchat')!,
                      icon: AppAssets.snapchat,
                      onTap: () {
                        Constants.openUrl(
                          'https://www.snapchat.com/add/badeeaic',
                        );
                      },
                    ),
                    //instagram
                    InformationListTile(
                      title: translator.translate('instagram')!,
                      icon: AppAssets.instagram,
                      onTap: () {
                        Constants.openUrl(
                          'https://www.instagram.com/badeeaic/?igshid=qegym9w8l9k4',
                        );
                      },
                    ),
                    //youtube
                    InformationListTile(
                      title: translator.translate('youtube')!,
                      icon: AppAssets.youtube,
                      onTap: () {
                        Constants.openUrl('https://www.youtube.com/@BadeeaIC');
                      },
                    ),
                    //whatsapp
                    InformationListTile(
                      title: translator.translate('whatsapp')!,
                      icon: AppAssets.whatsapp,
                      onTap: () {
                        Constants.openUrl(
                          'https://api.whatsapp.com/send/?phone=966500547472&text&app_absent=0',
                        );
                      },
                    ),
                    InformationListTile(
                      title: translator.translate('calling')!,
                      icon: AppAssets.phoneCall,
                      onTap: () {
                        Constants.openUrl('tel://+0500547472');
                      },
                    ),
                    InformationListTile(
                      title: translator.translate('email')!,
                      icon: AppAssets.mail,
                      onTap: () {
                        Constants.openUrl('mailto:info@badeea.com');
                      },
                    ),

                    const SizedBox(height: 20),
                    Text(
                      translator.translate('you_can_send_email_from_here')!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    DefaultTextFormField(
                      controller: nameController,
                      title: translator.translate('name'),
                      hintTxt: translator.translate('enter_your_name'),
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return translator.translate('name_required');
                        }
                        return null;
                      },
                      suffixIcon: Icon(
                        Icons.person_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DefaultTextFormField(
                      controller: emailController,
                      title: translator.translate('email'),
                      hintTxt: translator.translate('enter_your_email'),
                      inputData: TextInputType.emailAddress,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return translator.translate('email_required');
                        }
                        return null;
                      },
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DefaultTextFormField(
                      controller: titleController,
                      title: translator.translate('title'),
                      hintTxt: translator.translate('enter_title'),
                      inputData: TextInputType.text,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return translator.translate('title_is_required');
                        }
                        return null;
                      },
                      suffixIcon: Icon(Icons.title, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    DefaultTextFormField(
                      controller: messageController,
                      title: translator.translate('message'),
                      hintTxt: translator.translate('enter_your_message'),
                      maxLines: 5,
                      validationFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return translator.translate('message_required');
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultButton(
          btnLbl: translator.translate('send')!,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<ContactUsCubit>(context).contactUs(
                name: nameController.text,
                email: emailController.text,
                title: titleController.text,
                message: messageController.text,
              );
            }
          },
        ),
      ),
    );
  }
}

class InformationListTile extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;

  // Constructor

  const InformationListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        // padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          leading: Image.asset(icon, width: 30, height: 30),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
