import 'package:card_view_animation/card.dart';
import 'package:card_view_animation/enums.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String texttest = '';
  TextEditingController textEditingController;
  TextEditingController textEditingController2;
  bool change = true;
  @override
  void initState() {
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    textEditingController2 = TextEditingController();
    textEditingController2.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            height: 500,
            child: CardWidget(
              onDirectionChanged: (bool) {},
              isFront: change,
              idTextField: textEditingController2.text,
              pinTextField: textEditingController.text,
              containPin: false,
              cardType: CardType.none,
            ),
          ),
          TextField(
            controller: textEditingController,
          ),
          TextField(
            controller: textEditingController2,
          ),
        ],
      )),
    );
  }
}
