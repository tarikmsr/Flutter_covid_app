import '../objectbox.g.dart';
import 'qr_code.dart';

class MyData {
  List<MyQrCode>? qrCodes = null;
  var box = null;

  data() {}

  Future<void> initDb(Function callback) async {
    qrCodes = <MyQrCode>[];
    if (box == null) {
      final store = await openStore();
      box = store.box<MyQrCode>();
      store.close();
    }
    qrCodes?.addAll(box.getAll());
    callback(qrCodes);
  }

}