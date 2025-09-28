// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_paypal/flutter_paypal.dart';
// import 'package:ballaghny/core/utils/constants.dart';

// import 'payment_config.dart';

// Widget showPaypalPage({required String price,required String currency,
//   required String title,
//   required String description,
//   required Function onSuccessPayment
// }){
//  return UsePaypal(
//       sandboxMode: true,
//       clientId: PaymentConfig.PAYPAB_CLIENT_ID,
//       secretKey: PaymentConfig.PAYPAB_SECRET_KEY,
//       returnURL: "https://127.0.0.1:80/return",
//       cancelURL: "https://127.0.0.1:80",
//       transactions: [
//         {
//           "amount": {
//             "total": price,
//             "currency": currency,
//           },
//           "description": description,
//           "item_list": {
//             "items": [
//               {
//                 "name": title,
//                 "quantity": 1,
//                 "price": price,
//                 "currency": currency,
//               }
//             ],
//           }
//         }
//       ],
//       note: "Contact us for any questions on your order.",
//       onSuccess: (Map params) async {
//         log('Success: $params');
//         onSuccessPayment();
//       },
//       onError: (error) {
//         log('Error: $error');
//         Constants.showToast(message: 'Payment Error');
//       },
//       onCancel: (params) async {
//         log('Cancel: $params');
//         Constants.showToast(message: 'Payment Cancelled');
//       });
// }
