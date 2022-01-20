//import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
//import 'package:flutter_covid_dashboard_ui/config/styles.dart';
//import 'package:flutter_covid_dashboard_ui/config/palette.dart';
//import 'package:flutter_covid_dashboard_ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../QRCODE/intances.dart';
import '../QRCODE/qr_code.dart';
import '../QRCODE/qr_code_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../QRCODE/ContentTest.dart';
import '../QRCODE/details_display_screen.dart';
import '../config/palette.dart';

class WalletScreen extends StatefulWidget {

  @override
  _WalletScreenState createState() => _WalletScreenState();
}


class _WalletScreenState extends State<WalletScreen>  {

  @override
  void initState() {
    super.initState();
    myData.initDb(callbackList);
  }

  void _addQrCode() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCodeScreen(callback: callback)),
    );
  }

  void callback(MyQrCode qrCode) {
    setState(() {
      myData.qrCodes?.add(qrCode);
    });
  }

  void callbackList(List<MyQrCode> qrCodes) {
    setState(() {
      myData.qrCodes = qrCodes;
    });
  }


  static const IconData qr_code_scanner_rounded =
  IconData(0xf00cc, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        title: Text("My wallet"),
      ),
      body: Center(
          child: myData.qrCodes != null
              ? ListView.builder(
              itemCount: myData.qrCodes?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {

                    // if(myData.qrCodes![index].type.toString() == 'PCR'){
                    //   print(checkPCRresult(myData.qrCodes![index].content.toString()));
                    // }
                    // if(myData.qrCodes![index].type.toString() == 'Pass Covid'){
                    //   getPassData(myData.qrCodes![index].content.toString());
                    // }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsDisplayScreen(
                          callBack: callbackList,
                          qrCode: myData.qrCodes![index],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: QrImage(
                      data: myData.qrCodes![index].content.toString(),
                      version: QrVersions.auto,
                      size: 50.0,
                    ),
                    title: Text(myData.qrCodes![index].type.toString()),
                    subtitle: Text(formatDate(myData.qrCodes![index].date)),
                  ),
                );
              })
              : const CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQrCode,
        tooltip: 'New QrCode',
        backgroundColor: Palette.primaryColor,
        child: const Icon(qr_code_scanner_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}







  // @override
  // void initState() {
  //   super.initState();
  //   myData.initDb(callbackList);
  // }
  //
  // void _addQrCode() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => QrCodeScreen(callback: callback)),
  //   );
  // }
  //
  // void callback(MyQrCode qrCode) {
  //   setState(() {
  //     myData.qrCodes?.add(qrCode);
  //   });
  // }
  //
  // void callbackList(List<MyQrCode> qrCodes) {
  //   setState(() {
  //     myData.qrCodes = qrCodes;
  //   });
  // }

  //
  // static const IconData qr_code_scanner_rounded =
  // IconData(0xf00cc, fontFamily: 'MaterialIcons');



//
// SliverPadding _buildContentBar() {
//
//
//     return SliverPadding(
//       padding: const EdgeInsets.all(20.0),
//       sliver: SliverToBoxAdapter(
//
//
//           child: myData.qrCodes != null
//               ? ListView.builder(
//               itemCount: myData.qrCodes?.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//
//                     if(myData.qrCodes![index].type.toString() == 'PCR'){
//                       print("====test Result ==== ");
//                       print(checkPCRresult(myData.qrCodes![index].content.toString()));
//                     }
//                     if(myData.qrCodes![index].type.toString() == 'Pass Covid'){
//                       getPassData(myData.qrCodes![index].content.toString());
//                     }
//                     print("====156=====");
//
//
//
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailsDisplayScreen(
//                           callBack: callbackList,
//                           qrCode: myData.qrCodes![index],
//                         ),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     leading: QrImage(
//                       data: myData.qrCodes![index].content.toString(),
//                       version: QrVersions.auto,
//                       size: 50.0,
//                     ),
//                     title: Text(myData.qrCodes![index].type.toString()),
//                     subtitle: Text(formatDate(myData.qrCodes![index].date)),
//                   ),
//                 );
//               })
//               : const CircularProgressIndicator(),
//
//
//       ),
//
//   );
//   }
//
