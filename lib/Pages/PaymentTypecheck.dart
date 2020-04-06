import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class PaymentTypeCheck extends StatefulWidget {
  @override
  _PaymentTypeCheckState createState() => _PaymentTypeCheckState();
}

class _PaymentTypeCheckState extends State<PaymentTypeCheck> {
  final _isPop = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(!this._isPop){
           var d = await showDialog(
             context: context,
             builder: (context) => AlertDialog(
              title: Text("Close?"),
               actions: <Widget>[
                 FlatButton(
                   child: Text("OK"),
                   onPressed: () => Navigator.of(context).pop(true),
                 ),
                 FlatButton(
                   child: Text("NO"),
                   onPressed: () => Navigator.of(context).pop(),
                 )
               ],
             )
           );
           if(d != null) return Future.value(true);
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.grey
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20.0),
                  child: Text("결제 방식을 선택해주세요"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("Card"),
                      onPressed: () async => await this.cardBuyItem(context: context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Future<void> cardBuyItem({@required BuildContext context}) async{
    assert(context != null);
    final String _url = "http://www.google.com";
    var result =  await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => WebviewScaffold(
              appBar: AppBar(title: Text("BUY"),),
              url: _url,
//          userAgent: "",
//          headers: {
//            "":""
//          },
            )
        )
    );
    print("result $result");
  }
}
