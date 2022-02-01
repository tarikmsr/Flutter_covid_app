import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid_dashboard_ui/config/palette.dart';
import 'package:flutter_covid_dashboard_ui/config/styles.dart';
import 'package:flutter_covid_dashboard_ui/data/data.dart';
import 'package:flutter_covid_dashboard_ui/widgets/widgets.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          // _body(),




        ],
      ),
    );
  }



  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'About Us',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //
  // SliverPadding _body(){

    //   return CupertinoPageScaffold(
    //     navigationBar: const CupertinoNavigationBar(
    //       middle: Text('Paramètre',style:TextStyle(color: Colors.white)),
    //       backgroundColor: Colors.blue,
    //
    //     ),
    //     child: CupertinoSettings(
    //       items: <Widget>[
    //         const CSHeader('Luminosité'),
    //         CSWidget(
    //           CupertinoSlider(
    //             value: _slider,
    //             onChanged: (double value) => setState(() => _slider = value),
    //           ),
    //           style: CSWidgetStyle(
    //             icon: Icon(FontAwesomeIcons.sun),
    //           ),
    //           addPaddingToBorder: true,
    //         ),
    //         CSControl(
    //           nameWidget: Text('Auto Luminosité'),
    //           contentWidget: CupertinoSwitch(
    //             value: _switch,
    //             onChanged: (bool value) => setState(() => _switch = value),
    //           ),
    //           style: CSWidgetStyle(
    //             icon: Icon(FontAwesomeIcons.sun),
    //           ),
    //           addPaddingToBorder: false,
    //         ),
    //         const CSHeader('Selection'),
    //         CSSelection<int>(
    //           items: const <CSSelectionItem<int>>[
    //             CSSelectionItem<int>(text: 'Day mode', value: 0),
    //             CSSelectionItem<int>(text: 'Night mode', value: 1, subtitle: 'Subtitle'),
    //           ],
    //           onSelected: (value) => setState(() => _index = value),
    //           currentSelection: _index,
    //         ),
    //         const CSHeader('les langues'),
    //         CSSelection<int>(
    //           items: const <CSSelectionItem<int>>[
    //             CSSelectionItem<int>(text: 'Français', value: 0),
    //             CSSelectionItem<int>(text: 'English', value: 1),
    //             CSSelectionItem<int>(text: 'العربية', value: 2),
    //           ],
    //           onSelected: (value) => setState(() => _index = value),
    //           currentSelection: _index,
    //         ),
    //         const CSDescription(
    //           'choisir la langue qui vous voulez !',
    //         ),
    //         const CSHeader(""),
    //
    //
    //       ],
    //     ),
    //   );
    //
    //
    // }






}
