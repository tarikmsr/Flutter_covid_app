import '../objectbox.g.dart';
import 'qr_code.dart';

class MyData {
  List<MyQrCode>? qrCodes = null;
  var box = null;
  var store;

  data() {}

  Future<void> initDb(Function callback) async {
    try{
      store = await openStore();
    }catch(e){
      store.close();
      store = await openStore();
    }
    if (box == null) {
      box = store.box<MyQrCode>();
    }else{
      box = store.box<MyQrCode>();
    }

    qrCodes = <MyQrCode>[];
    try{
      qrCodes?.addAll(box.getAll());
    }catch(e){
      store = await openStore();
      box = store.box<MyQrCode>();
      qrCodes?.addAll(box.getAll());

    }
    // qrCodes?.addAll(box.getAll());
    callback(qrCodes);
  }

}