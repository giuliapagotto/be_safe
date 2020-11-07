import 'dart:ui';

import 'package:besafehealthcare/src/pages/details.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:besafehealthcare/src/pages/call.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:besafehealthcare/src/pages/configuration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  @override

  
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  PageController _pageController;
  var selectedPage;
  
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    selectedPage = 0;
  }


  Widget build(BuildContext context){
    return Scaffold(
      
     body: Container(
        color: Colors.amber,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            Center(
            child: Container(
              child:  Text("Teste1", style: TextStyle(color: Colors.white),)//first screen,
                ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column( 
                children: [
                  SizedBox(height: 25,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    margin: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.search),
                        Text('Encontre a ajuda que precisa'),
                        Icon(Icons.settings, color: Colors.white,)
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(right: 10),
                    height: 120,
                    child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context,index){
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Image.asset(categories[index]['iconPath'],
                              height: 42,
                              width: 42,color: Colors.grey[700],),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 17), 
                              child:Text(categories[index]['name'], style: TextStyle(fontSize: 12,)))
                          ],
                        ),
                      );
                    },
                    ),
                  ),
                  
                Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: testelista.length,
                    itemBuilder: (context,index){
                      
                      return GestureDetector(
                       
                        onTap: (){
                          print(testelista[index]['name']);
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailsScreen(
                            nome: testelista[index]["name"],
                            profissao: testelista[index]["profissao"],
                            imagem: testelista[index]['iconPath'],
                            descricao: testelista[index]['descricao']
                            )),
                        );
                        },
                        child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Container(
                              height: 150,
                              width: 300,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(children: [
                                Image.asset(testelista[index]['iconPath'], height: 110, width: 110),
                                Container(
                                  height: 120,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Row(children: [
                                      Text(testelista[index]['name'], style: TextStyle(fontSize: 16),),
                                     
                                       Icon(Icons.chevron_right_outlined, color: Colors.grey),
                                    ],),
                                    SizedBox(height: 5),
                                    Text(testelista[index]['profissao']),
                                    SizedBox(height: 45),
                                    Row(children: [
                                      Text("Consulta: R\$ "),
                                      Text(testelista[index]['valor'], style: TextStyle(color: Colors.green),),
                                    ],)
                                ],),)
                              ],)
                              
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ));
                    },
                    ),
                  ),               
                ],
              )
            )
          ),
          Center(
            child: Container(
              child: Text("Teste3", style: TextStyle(color: Colors.white),)//second screen
            ),
          ),
          Center(
            child: Container(
              color: Colors.amber,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 700,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: _channelController,
                        decoration: InputDecoration(
                          errorText:
                              _validateError ? 'Channel name is mandatory' : null,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          hintText: 'Channel name',
                        ),
                      ))
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        title: Text(ClientRole.Broadcaster.toString()),
                        leading: Radio(
                          value: ClientRole.Broadcaster,
                          groupValue: _role,
                          onChanged: (ClientRole value) {
                            setState(() {
                              _role = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(ClientRole.Audience.toString()),
                        leading: Radio(
                          value: ClientRole.Audience,
                          groupValue: _role,
                          onChanged: (ClientRole value) {
                            setState(() {
                              _role = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: onJoin,
                            child: Text('Join'),
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ],
        )
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.amber,
        buttonBackgroundColor: Colors.white,
        height: 50,
        items: <Widget>[
          Icon(Icons.monetization_on, size: 20, color: Colors.black,),
          Icon(Icons.search, size: 20, color: Colors.black,),
          Icon(Icons.home, size: 20, color: Colors.black,),
          Icon(Icons.person_pin, size: 20, color: Colors.black,),
          Icon(Icons.settings, size: 20, color: Colors.black,)
        ],
        index: 2,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index){
           if(index == 0){
           _pageController.jumpToPage(0);
                setState(() {
                  selectedPage = 0;
                });
          }
          if(index == 1){
            _pageController.jumpToPage(1);
                setState(() {
                  selectedPage = 1;
                });
          }
           if(index == 2){
            _pageController.jumpToPage(2);
                setState(() {
                  selectedPage = 2;
                });
          }
          if(index == 3){
            _pageController.jumpToPage(3);
                setState(() {
                  selectedPage = 3;
                });
          }
          debugPrint("Current Index is: $index");
        },
        ),
      );
  }

Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

}

