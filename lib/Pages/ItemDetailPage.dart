import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:payapp/Pages/PaymentTypecheck.dart';


class ItemDetailPage extends StatelessWidget {

  // Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                /// @Todo : Contents
                Container(
                  height: 300.0,
                  color: Colors.red,
                ),
                Container(
                  height: 300.0,
                  color: Colors.blue,
                ),
                Container(
                  height: 300.0,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => this.nextPage(context: context),
                  child: Center(
                    child: Text("Buy"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Center(
                    child: Text("Cart"),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  void nextPage({BuildContext context}) async{
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => PaymentTypeCheck()
        )
    );
  }
}
