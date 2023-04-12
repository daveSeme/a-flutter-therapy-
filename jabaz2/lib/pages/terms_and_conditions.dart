// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:jabaz2/constants/colors.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class TermsAndConditions extends StatefulWidget {
//   const TermsAndConditions({Key? key}) : super(key: key);

//   @override
//   State<TermsAndConditions> createState() => _TermsAndConditionsState();
// }

// class _TermsAndConditionsState extends State<TermsAndConditions> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: primaryColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text('Terms and Conditions'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: WebView(
//           initialUrl: 'https://htmlburger.com/blog/website-preloaders/',
//           onWebViewCreated: (WebViewController webViewController) {
//             _controller = webViewController;
//             _loadHtmlFromAssets();
//           },
//         ),
//       ),
//     );
//   }

//   _loadHtmlFromAssets() async {
//     String fileText =
//         await rootBundle.loadString('assets/html/zara_terms.html');
//     _controller.loadUrl(Uri.dataFromString(fileText,
//             mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//         .toString());
//   }
// }
