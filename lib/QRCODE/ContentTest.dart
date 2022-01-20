import 'dart:convert';
import 'dart:io';
import 'package:base45/base45.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_covid_dashboard_ui/QRCODE/qr_code.dart';

String checkPCRresult(String qrCode){
  if(qrCode.lastIndexOf('NEGATIVE')!= -1 ){
    return 'NEGATIVE';
  }else return 'POSITIVE';
}

String getData(MyQrCode qrCode){

  String _qrCode = qrCode.content.toString();
  String data = _qrCode;
  if(qrCode.type == "PCR") {
    int startIndex = _qrCode.lastIndexOf('COVID-19');
    int endIndex = _qrCode.lastIndexOf('Ministry of Health');

    if(startIndex != -1 && endIndex != -1) {
      data = _qrCode.toString().substring(startIndex, endIndex);
      //data.replaceAll ("NEGATIVE", "POSITIVE");
      return data;
    }
  }else if(qrCode.type == "Pass Covid"){
    var base45_decoded = Base45.decode(_qrCode.substring(4));
    var inflated = zlib.decode(base45_decoded);
    final result = Cose.decodeAndVerify(
      inflated,
      {'kid': '''pem'''},
    );


    //print("Country:");
    //print(result.payload.entries.first);
    print(result.payload.entries.last);
    String data = (result.payload.entries.last).toString();

    int startIndex = data.lastIndexOf('dob');
    int endIndex = data.lastIndexOf('fnt');

    if(startIndex != -1 && endIndex != -1) {
      String newdata = data.toString().substring(startIndex, endIndex).replaceAll("dob", "Date naissance").replaceAll("nam", "Name").replaceAll("{fn:", "").replaceAll("gn:", "").replaceAll(", Name", "\nName").replaceAll(",", "").replaceAll("K,", "K");

      print(newdata);
      return newdata;
    }else{
      return data;
    }
  }else{
    return data;
  }
  return data;
}

void getPassData(String qrCode){
  //String testData= 'NCFOXN%TS3DH3ZSUZK+.V0ETD%65NL-AH-R6IOO6+IUKRG*I.I5BROCWAAT4V22F/8X*G3M9JUPY0BX/KR96R/S09T./0LWTKD33236J3TA3M*4VV2 73-E3GG396B-43O058YIB73A*G3W19UEBY5:PI0EGSP4*2DN43U*0CEBQ/GXQFY73CIBC:G 7376BXBJBAJ UNFMJCRN0H3PQN*E33H3OA70M3FMJIJN523.K5QZ4A+2XEN QT QTHC31M3+E32R44\$28A9H0D3ZCL4JMYAZ+S-A5\$XKX6T2YC 35H/ITX8GL2-LH/CJTK96L6SR9MU9RFGJA6Q3QR\$P2OIC0JVLA8J3ET3:H3A+2+33U SAAUOT3TPTO4UBZIC0JKQTL*QDKBO.AI9BVYTOCFOPS4IJCOT0\$89NT2V457U8+9W2KQ-7LF9-DF07U\$B97JJ1D7WKP/HLIJLRKF1MFHJP7NVDEBU1J*Z222E.GJF67Z JA6B.38O4BH*HB0EGLE2%V -3O+J3.PI2G:M1SSP2Y3D38-G9C+Q3OT/.J1CDLKOYUV5C3W1A:75S4LB:6REPKM3ZYO4+QDNDLT2*ESLIH';
  //var base45_decoded = Base45.decode(testData);


  var base45_decoded = Base45.decode(qrCode.substring(4));
  var inflated = zlib.decode(base45_decoded);
  final result = Cose.decodeAndVerify(
    inflated,
    {'kid': '''pem'''},
  );
  print(result.payload);
  print(result.payload.entries.last);
} //getPassData
