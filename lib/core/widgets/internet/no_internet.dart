// import 'package:flutter/material.dart';
// import '../../../config/locale/app_localizations.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/assets_manager.dart';

// class NoInternet extends StatelessWidget {
//   const NoInternet({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async => false,
//         child: Scaffold(
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(height: 110),
//               Center(
//                 child: Image.asset(
//                   ImageAssets.noInternet,
//                   height: 210,
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 AppLocalizations.of(context)!.translate('opps')!,
//                 style: TextStyle(
//                     color: AppColors.boldPurple,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 40),
//                 alignment: Alignment.center,
//                 child: Text(
//                     AppLocalizations.of(context)!.translate(
//                         'please_check_your_internet_connection_and_try_again')!,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: AppColors.lightPurple,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600)),
//               ),
//               const SizedBox(
//                 height: 80,
//               ),
//               SizedBox(
//                   width: 150,
//                   height: 50,
//                   child: Builder(
//                       builder: (context) => ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               primary: Colors.white,
//                               onPrimary: Colors.white,
//                               side: BorderSide(color: AppColors.boldBlack),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(25)),
//                             ),
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   AppLocalizations.of(context)!
//                                       .translate('try_again')!,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.dark,
//                                       fontSize: 20),
//                                 )),
//                           )))
//             ],
//           ),
//         ));
//   }
// }
