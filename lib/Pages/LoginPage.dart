import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payapp/Pages/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  RunMutation runMutation;
  LoginPage({this.runMutation});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FocusNode _idFocus = new FocusNode();
  final FocusNode _pwFocus = new FocusNode();

  final TextEditingController _idController = new TextEditingController();
  final TextEditingController _pwController = new TextEditingController();


  SharedPreferences pref;

  String idErrMsg = "";
  String pwErrMsg = "";


  @override
  void initState() {
    Future.microtask(() async{
      pref = await SharedPreferences.getInstance();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(50.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                )
              ),
              Flexible(
                child: Container(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.center,
                            child: TextField(
                              maxLines: 1,
                              focusNode: _idFocus,
                              textInputAction: TextInputAction.next,
                              cursorColor: Colors.black,
                              controller: _idController,
                              autocorrect: true,
                              enabled: true,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (String _){
                                setState(() {
                                  idErrMsg = "";
                                });
                              },
                              onSubmitted: (String v)
                              => this._inputFieldFocusChange(
                                  context: context,
                                  currentFocus: this._idFocus,
                                  nextFocus: this._pwFocus
                              ),
                              decoration: InputDecoration(
                                  filled: true,
                                  errorText: idErrMsg,
                                  errorMaxLines: 1,
                                  fillColor: Colors.grey[200],
                                  hintText: "E-Mail",
                                  prefixIcon: Icon(Icons.person,color: Colors.black,),
                                  suffixIcon: this._inputIcon(controller: this._idController, currentFocus: this._idFocus),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            alignment: Alignment.center,
                            child: TextField(
                              maxLines: 1,
                              focusNode: _pwFocus,
                              textInputAction: TextInputAction.done,
                              cursorColor: Colors.black,
                              controller: _pwController,
                              obscureText: true,
                              onSubmitted: (String v) => this._validation(),
                              onChanged: (String _){
                                setState(() {
                                  this.pwErrMsg = "";
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                errorMaxLines: 1,
                                errorText: this.pwErrMsg,
                                fillColor: Colors.grey[200],
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock_outline, color: Colors.black,),
                                suffixIcon: this._inputIcon(
                                  controller: this._pwController,
                                  currentFocus: this._pwFocus,
                                ),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        child: MaterialButton(
                          onPressed: () async => await this._validation(),
                          child: Text("Login"),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clickClearText({
    @required TextEditingController targetVar,
    @required FocusNode currentFocus,
  }){
    assert(targetVar != null); assert(currentFocus != null);
    Future.delayed(Duration.zero,(){
      currentFocus.unfocus();
    }).then((_) => targetVar.clear());
  }

  Widget _inputIcon({TextEditingController controller, FocusNode currentFocus}){
    if(controller.text == "") return null;
    else return IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        this.clickClearText(targetVar: controller, currentFocus: currentFocus);
        print(controller.text);
      },
    );
  }
  void _inputFieldFocusChange({
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus
  }) => Future.microtask(() => currentFocus.unfocus())
        .then((_) => FocusScope.of(context).requestFocus(nextFocus));

  Future<void> _validation() async{
    print(_idController.text);
    print(_pwController.text);
    await idValidation().then((bool check) {
      print(check);
      if (!check) {
        setState(() {
          this.idErrMsg = "id오류";
        });
        return;
      }
    }).then((_) async{
      await pwValidation().then((bool check){
        print(check);
        if(!check){
          setState(() {
            this.pwErrMsg = "pw오류";
          });
          return;
        }
        else{
          widget.runMutation({});
        }
      });
    });
  }

  Future<bool> idValidation(){
    String _id = this._idController.text;
    if(_id.length <= 4) return Future.value(false);
    if(_id.indexOf("@") == -1) return Future.value(false);
    if(_id.indexOf(".com") == -1) return Future.value(false);
    if(_id.split("@")[0].length <= 4) return Future.value(false);
    return Future.value(true);
  }

  Future<bool> pwValidation(){
    String _pw = this._pwController.text;
    if(_pw.length <= 4) return Future.value(false);
    if(_pw.contains(new RegExp(r"[!-)]")) == false) return Future.value(false);
    return Future.value(true);
  }


  @override
  void dispose() {
    this._idController.dispose();
    this._pwController.dispose();
    super.dispose();
  }
}

