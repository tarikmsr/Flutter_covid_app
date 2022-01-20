// import 'package:flutter/material.dart';
// import 'package:flutter_covid_dashboard_ui/QRCODE/intances.dart';
// import 'package:flutter_covid_dashboard_ui/config/palette.dart';
// import 'package:flutter_covid_dashboard_ui/widgets/widgets.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import '../QRCODE/ContentTest.dart';
// import '../QRCODE/details_display_screen.dart';
// import '../QRCODE/qr_code.dart';
// import '../QRCODE/qr_code_screen.dart';
//
//
// class WalletScreen extends StatefulWidget {
//   @override
//   _WalletScreenState createState() => _WalletScreenState();
// }
//
// class _WalletScreenState extends State<WalletScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     myData.initDb(callbackList);
//   }
//
//   void _addQrCode() {
//     print("====26====");
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => QrCodeScreen(callback: callback)),
//     );
//     print("====32====");
//   }
//
//   void callback(MyQrCode qrCode) {
//     print("====36=====");
//     setState(() {
//       myData.qrCodes?.add(qrCode);
//       print("====39====");
//     });
//   }
//
//   void callbackList(List<MyQrCode> qrCodes) {
//     print("====44=====");
//     setState(() {
//       myData.qrCodes = qrCodes;
//     });
//     print("====48=====");
//   }
//
//
//   static const IconData qr_code_scanner_rounded =
//   IconData(0xf00cc, fontFamily: 'MaterialIcons');
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Palette.primaryColor,
//       appBar: CustomAppBar(),
//       body: CustomScrollView(
//         physics: ClampingScrollPhysics(),
//         slivers: <Widget>[
//           _buildHeader(),
//
//           SliverPadding(
//             padding: const EdgeInsets.only(top: 20.0,bottom:20.0),
//             sliver: SliverToBoxAdapter(
//
//                 child: myData.qrCodes != null
//                     ? ListView.builder(
//                     itemCount: myData.qrCodes?.length,
//                     itemBuilder: (BuildContext context, int index) {
//
//                       return GestureDetector(
//                         onTap: () {
//
//                           print("====73=====");
//
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DetailsDisplayScreen(
//                                 callBack: callbackList,
//                                 qrCode: myData.qrCodes![index],
//                               ),
//                             ),
//                           );
//
//                         },
//                         child: ListTile(
//                           leading: QrImage(
//                             data: myData.qrCodes![index].content.toString(),
//                             version: QrVersions.auto,
//                             size: 50.0,
//                           ),
//                           title: Text(myData.qrCodes![index].type.toString()),
//                           subtitle: Text(formatDate(myData.qrCodes![index].date)),
//                         ),
//                       );
//                     })
//                     : const CircularProgressIndicator(),
//
//             ),
//           ),
//
//         ],
//
//       ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _addQrCode,
//           tooltip: 'New QrCode',
//           child: const Icon(qr_code_scanner_rounded),
//         ),
//     );
//   }
//
//
//
//
//   SliverPadding _buildHeader() {
//     return SliverPadding(
//       padding: const EdgeInsets.all(20.0),
//       sliver: SliverToBoxAdapter(
//         child: Text(
//           'My wallet',
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 25.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
// }
