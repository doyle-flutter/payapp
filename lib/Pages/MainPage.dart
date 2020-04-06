import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payapp/Pages/QrSannerPage.dart';
import 'package:payapp/Pages/ShoppingPage.dart';
import 'package:permission_handler/permission_handler.dart';


class MainPage extends StatefulWidget {
  ValueNotifier<GraphQLClient> client;
  MainPage({this.client});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{

  List imgSrc = [
    'https://cdn.pixabay.com/photo/2020/02/23/12/02/bergsee-4873148__340.jpg',
    'https://cdn.pixabay.com/photo/2019/11/03/20/11/portrait-4599553__340.jpg',
    'https://cdn.pixabay.com/photo/2020/01/27/19/22/piano-4798138__340.jpg',
  ];

  String money = '9,000.00';

  EdgeInsetsGeometry _pd = EdgeInsets.symmetric(
      vertical: 16.0, horizontal: 10.0
  );

  List<Map<String, dynamic>> productDatas = [
    {
      'title':'타이틀1',
      'name':'상품명1',
      'price':'50000',
      'textColor':'#ccc',
      'bgImg':'https://cdn.pixabay.com/photo/2020/03/04/21/39/palma-4902795__340.jpg',
      'img':'https://cdn.pixabay.com/photo/2017/09/17/02/02/png-2757379__340.png',
      'eventImg':'https://cdn.pixabay.com/photo/2017/07/04/23/41/white-wings-2473023__340.png'
    },
    {
      'title':'타이틀2',
      'name':'상품명1',
      'price':'50000',
      'textColor':'#ccc',
      'bgImg':'https://cdn.pixabay.com/photo/2020/03/04/21/39/palma-4902795__340.jpg',
      'img':'https://cdn.pixabay.com/photo/2017/09/17/02/02/png-2757379__340.png',
      'eventImg':'https://cdn.pixabay.com/photo/2017/07/04/23/41/white-wings-2473023__340.png'
    },
    {
      'title':'타이틀3',
      'name':'상품명1',
      'price':'50000',
      'textColor':'#ccc',
      'bgImg':'https://cdn.pixabay.com/photo/2020/03/04/21/39/palma-4902795__340.jpg',
      'img':'https://cdn.pixabay.com/photo/2017/09/17/02/02/png-2757379__340.png',
      'eventImg':'https://cdn.pixabay.com/photo/2017/07/04/23/41/white-wings-2473023__340.png'
    },
  ];

  double cHeight = 200.0;

  GlobalKey<ScaffoldState> scaffoldContext = new GlobalKey<ScaffoldState>();

  Animation<Offset> customDrawer;
  AnimationController customDrawerCt;

  TextStyle customDrawerTitleSt = new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
  TextStyle customDrawerDesSt = new TextStyle(color: Colors.white);

  List customDrawerMenuItem = ['내 정보', '충전', '쿠폰', '구매', '이용 내역', 'EGB 뉴스', '고객지원', '설정'];


  @override
  void initState() {
    customDrawerCt = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    customDrawerCt.addListener((){
      setState(() {});
    });
    customDrawer = new Tween(begin: Offset(1,0),end: Offset(0,0)).animate(customDrawerCt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this.scaffoldContext,
      appBar: AppBar(
        backgroundColor: Colors.amber[300],
        title: Text("LOGO222"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: (){

            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    bottom: 20.0
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/4,
                      child: CarouselSlider(
                        viewportFraction: 1.0,
                        aspectRatio: 16/9,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        items: imgSrc.map((i) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(i),
                                  fit: BoxFit.cover
                              )
                          ),
                        )).toList(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/5,
                      decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      margin: _pd,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.white, width: 1.0)
                                    )
                                ),
                                margin: EdgeInsets.symmetric( horizontal: 40.0 ),
                                child: Text("나의 EGB PAY 잔고",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("\$ $money",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.red,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.monetization_on),
                                  Text("충전하기")
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.red,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.map),
                                  Text("쿠폰")
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.dashboard),
                                  Text("이용내")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: cHeight * this.productDatas.length,
                      child: ListView.builder(
                          padding: this._pd,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: this.productDatas.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: this.cHeight-20.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(this.productDatas[index]['bgImg']),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width*0.5,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  image: DecorationImage(
                                                      image: NetworkImage(this.productDatas[index]['eventImg']),
                                                      fit: BoxFit.cover
                                                  )
                                              )
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            color: Colors.black45,
                                            padding: EdgeInsets.only( left: 20.0, ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    this.productDatas[index]['title'],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.orange[500]
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    this.productDatas[index]['name'],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15.0
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                                  child: Text(
                                                    "\$ ${this.productDatas[index]['price']}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: MediaQuery.of(context).size.width*0.3,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          image: DecorationImage(
                                              image: NetworkImage(this.productDatas[index]['img']),
                                              fit: BoxFit.fitWidth
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: SlideTransition(
                  position: this.customDrawer,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              this.customDrawerCt.reverse();
                            },
                            child: Container(
                              color: this.customDrawerCt.isCompleted ? Colors.white30 : null
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            color:Colors.amberAccent,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      left: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text("ㅇㅇㅇ님", style: this.customDrawerTitleSt,),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10.0),
                                          child: Text("안녕하세요!", style: this.customDrawerTitleSt),
                                        ),
                                        Container(
                                          child: Text("현재보유하신 EGB PAY 잔고는", style: this.customDrawerDesSt),
                                        ),
                                        Container(
                                          child: Text("\$ ${this.money}", style: this.customDrawerTitleSt),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: this.customDrawerMenuItem.map(
                                          (e) => Container(
                                            child: ListTile(
                                              onTap: (){},
                                              title: Text(e.toString(), style: this.customDrawerDesSt,),
                                              trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                                            ),
                                          )
                                        ).toList(),
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue[900],
        // backgroundColor: Color(0xffb74093),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange,
        onTap: (int index) async{
          print(index);
//          if(index == 4){
//            this.customDrawerCt.isCompleted
//              ? this.customDrawerCt.reverse()
//              : this.customDrawerCt.forward();
//          }

          switch(index){
            case 0: break;
            case 1: break;
            case 2: {
              await this._qrScanner();
              break;
            }
            case 3: this.moveShopping(context:context); break;
            case 4: this.customDrawerCt.isCompleted ? this.customDrawerCt.reverse() : this.customDrawerCt.forward();
          }


        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("홈")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_size_select_actual),
              title: Text("충전")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text("쿠폰")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              title: Text("쇼핑")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_right),
              title: Text("전체")
          ),
        ],
      ),
    );
  }
  void moveShopping({ @required BuildContext context}){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GraphQLProvider(
        client: widget.client,
        child: new ShoppingPage()),
      )
    );
  }

  Future<String> _qrScanner() async{


    print(await Permission.camera.isGranted);
    await Permission.camera.request();


    return await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => QrScannerPage()
      )
    );
  }

}



class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin{

  Animation<Offset> animValue;
  AnimationController animationController;

  @override
  void initState() {
    this.animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    this.animValue = new Tween<Offset>(begin: Offset(1,0), end: Offset(0,0))
        .animate(this.animationController)
      ..addListener((){setState(() {});});
    super.initState();
  }

  void customDrawerPlay({AnimationController animationController}){
    animationController.forward();
    if(animationController.status.index == 3) animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            title: Container()
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new),
              title: Container()
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text("Click"),
                onPressed: () => this.customDrawerPlay(animationController: this.animationController),
              ),
            ),
            SlideTransition(
              position: this.animValue,
              child: AnimatedBuilder(
                animation: this.animationController,
                builder: (BuildContext context, Widget widget) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 60.0,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => customDrawerPlay(animationController: this.animationController),
                          child: Container(
                              color: this.animationController.status.index == 3 ? Colors.black12 : null
                          ),
                        ),
                      ),
                      Expanded(
                        flex:1,
                        child: Container(
                          color: Colors.red,
                          child: widget,
                        ),
                      ),
                    ],
                  ),
                ),
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(index.toString()),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
