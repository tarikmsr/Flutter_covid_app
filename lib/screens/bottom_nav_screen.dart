import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/screens/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:objectbox/objectbox.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;
import '../objectbox.g.dart';

String serverDNS = 'http://462d-105-159-3-22.ngrok.io';
@Entity()
class DeviceModel {
  int id;
  String? deviceId;
  @Property(type: PropertyType.date)
  DateTime date = DateTime.now();
  @override
  String toString() {
    return '''{"deviceId": "$deviceId", "date": "$date"}''';
  }
  DeviceModel(this.id, this.deviceId);
}


Future<String> serverPost(String? id ,DateTime date ) async{
  var res = await http.post(
    Uri.parse( serverDNS + '/api/notify'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String? >{
      'id' : id,
      'date' : date.toString(),
    }),
  );
  developer.log("res.body : ");
  developer.log(res.body);
  return res.body;
}

void my_toast(String my_msg){
  Fluttertoast.showToast(
    msg: my_msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
  );
}

int random_choice(){
  var rng = new Random();
  return rng.nextInt(2);
}



class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}


void my_async_post() async{
  List<DeviceModel> mylist =  await readFromObjectBox();
  mylist.forEach((element) {
    serverPost(element.deviceId , element.date);
    sleep(Duration(seconds:1));
  });
}


Future<List<DeviceModel>> readFromObjectBox() async{
  final Store _store = await openStore();
  var _box = null;
  _box = _store.box<DeviceModel>();
  Query<DeviceModel> query = _box.query().build();
  List<DeviceModel> joes = query.find();
  query.close();
  developer.log("================>>>>>>>>>><<<<reading form <<<<<<<<<====================");
  developer.log("${joes}");
  _store.close();
  return joes;
}




class _BottomNavScreenState extends State<BottomNavScreen> {
  List<Device> devices = [];
  List<Device> connectedDevices = [];
  late NearbyService nearbyService;
  late StreamSubscription subscription;
  late StreamSubscription receivedDataSubscription;
  bool c = true;

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // Unique ID on Android
    }
  }

  _onButtonClicked(Device device) {
    switch (device.state) {
      case SessionState.notConnected:
        nearbyService.invitePeer(
          deviceID: device.deviceId,
          deviceName: device.deviceName,
        );
        return 1;
    // break;
      case SessionState.connected:
        nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        break;
    }
  }

  void insertToObjectBox(String devid) async{
    final Store _store = await openStore();
    var _box = null;
    _box = _store.box<DeviceModel>();
    DeviceModel d = new DeviceModel(0, devid);
    _box.put(d);
    developer.log(" Inserting to database");
    _store.close();
  }

  // Future<List<DeviceModel>> readFromObjectBox() async{
  //   final Store _store = await openStore();
  //   var _box = null;
  //   _box = _store.box<DeviceModel>();
  //   Query<DeviceModel> query = _box.query().build();
  //   List<DeviceModel> joes = query.find();
  //   query.close();
  //   //developer.log("================>>>>>>>>>><<<<<<<<<<<<x<<<<<<<<<====================");
  //   //developer.log("${joes}");
  //   _store.close();
  //   return joes;
  // }

  void allDevices(){
    readFromObjectBox();
    devices.forEach((element) {
      if( element.state == SessionState.notConnected ){
        developer.log("device ${element.deviceId} not connected we should connect ");
        while (true){
          if (_onButtonClicked(element) == 1 ){
            c = false;
            developer.log("connection Done !! and waiting 5 secs and storing ${element.deviceId}");
            insertToObjectBox('${element.deviceId}');
            sleep(Duration(seconds:4));
            _getId().then((id) {
              String? deviceId = id;
              nearbyService.sendMessage(element.deviceId, "${deviceId}");
              developer.log("I sent My Id :${deviceId} to device ${element.deviceId} ");
              my_toast("sent ${deviceId} to ${element.deviceId}");
              nearbyService.disconnectPeer(deviceID: element.deviceId);
            });
            break;
          }
        }
      }
    });
  }

  void init_browser(bool flag) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(c){
        allDevices();
      }
    });

    nearbyService = NearbyService();
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }

    await nearbyService.init(
        serviceType: 'mp-connection',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            if (flag) {
              developer.log("Browsing !");
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(Duration(microseconds: 200));
              await nearbyService.startBrowsingForPeers();
            } else {
              developer.log("Advertising !");
              await nearbyService.stopAdvertisingPeer();
              await nearbyService.stopBrowsingForPeers();
              await Future.delayed(Duration(microseconds: 200));
              await nearbyService.startAdvertisingPeer();
              await nearbyService.startBrowsingForPeers();
            }
          }
        });

    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
          devicesList.forEach((element) {
            if (Platform.isAndroid) {
              if (element.state == SessionState.connected) {
                nearbyService.stopBrowsingForPeers();
              } else {
                nearbyService.startBrowsingForPeers();
              }
            }
          });

          devices.clear();
          devices.addAll(devicesList);
          connectedDevices.clear();
          connectedDevices.addAll(devicesList
              .where((d) => d.state == SessionState.connected)
              .toList());
        });

    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
          developer.log("We v recieved : ${jsonEncode(data)}");
        });
  }

  // void my_async_post() async{
  //   List<DeviceModel> mylist =  await readFromObjectBox();
  //   developer.log('my_async_post   -=-==-= ${mylist}');
  //   var res = serverPost(
  //       mylist
  //   );
  // }


  final List _screens = [
    HomeScreen(),
    StatsScreen(),
    //Scaffold(),
    WalletScreen(),
    AboutScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    //my_async_post();
    Timer.periodic(Duration(seconds: 10), (timer) {
      if(random_choice() == 0){
        init_browser(true); //Browsing !
      }else{
        init_browser(false); //Advertising !
      }
    });
    // init_browser();

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [Icons.home, Icons.query_stats,Icons.account_balance_wallet_outlined, Icons.info] // Icons.qr_code_2,
            .asMap()
            .map((key, value) => MapEntry(
          key,
          BottomNavigationBarItem(
            // title: Text(''),
            label: '',
            icon: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: _currentIndex == key
                    ? Colors.blue[600]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(value),
            ),
          ),
        ))
            .values
            .toList(),
      ),
    );
  }
}