import 'dart:convert';
import 'dart:ui';
import 'package:besafehealthcare/src/pages/details.dart';
import 'package:besafehealthcare/src/pages/register.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async'; 
import 'package:fluttertoast/fluttertoast.dart';
import 'package:besafehealthcare/src/pages/configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


final kHintTextStyle = TextStyle(
  color: Colors.amber[200],
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

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

  String login;
  String senha;
  bool emptyL = false;
  bool emptyS = false;
  String msgToast = '';
  bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //LOGIN
  _loginRequest() async {
    // set up POST request arguments
    String url = 'https://vendasprojeto.herokuapp.com/authenticate';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"login": "${login}","senha": "${senha}"}';
    // make POST request
    http.Response response = await http.post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String responseBody = response.body;
    Map<String, dynamic> usuario = jsonDecode(responseBody);
    print(usuario);
    //home navigation
    if (statusCode == 200) {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      var gestor = usuario['user']['gestor'];
      if (gestor == true) {
        //set instance true
        Future<bool> _setBool() async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("loginGestor", gestor);
          print(prefs.getBool('loginGestor'));
        }
        _setBool();
      }
    }
    //LOGIN OU SENHA INVALIDOS
    if (statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Login e/ou senha inválidos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


//TELA DE LOGIN - WIDGETS
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Login',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.amber, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.amber,
              ),
              hintText: 'Login',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                setState(() {
                  emptyL = true;
                });
              }
              return null;
            },
            onSaved: (String value) {
              login = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildSenhaTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(color: Colors.amber, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.amber,
              ),
              hintText: 'Senha',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                emptyS = true;
              }
              return null;
            },
            onSaved: (String value) {
              senha = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildEsqueceuSenhaBtn() {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Esqueceu sua senha?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildLembrarAcessoCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Lembrar meu acesso',
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          _loginRequest();
          if (emptyL == true && emptyS == false) {
            msgToast = 'Informe o login';
          }
          if (emptyL == false && emptyS == true) {
            msgToast = 'Informe sua senha';
          }
          if (emptyL == true && emptyS == true) {
            msgToast = 'Informe Login e Senha';
          }
          if (msgToast != '') {
            Fluttertoast.showToast(
                msg: msgToast,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          emptyL = false;
          emptyS = false;
          msgToast = '';
        },
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text('LOGIN',
            style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
      ),
    );
  }

  Widget _buildCadastrarBtn() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Não tem uma conta? Cadastre-se',
          style: kLabelStyle,
        ),
      ),
    );
  }

  //TELA ----- WIDGETS

  PageController _pageController;
  var selectedPage;
  
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
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
                    itemCount: users.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailsScreen(
                            user: users[index],
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
                                Image.asset(users[index].iconPath, height: 110, width: 110),
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
                                      Text(users[index].name, style: TextStyle(fontSize: 16),),
                                     
                                       Icon(Icons.chevron_right_outlined, color: Colors.grey),
                                    ],),
                                    SizedBox(height: 5),
                                    Text(users[index].profissao),
                                    SizedBox(height: 45),
                                    Row(children: [
                                      Text("Consulta: R\$ "),
                                      Text(users[index].valor, style: TextStyle(color: Colors.green),),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                  height: 200,
                  color: Colors.red,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                          )
                        ),
                        color: Colors.white,
                      ),
                      Container(
                        height: 150,
                        width: 300,
                        color: Colors.black,

                      )
                    ],
                  )
                ],
              )
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Faça Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 28.0),
                      _buildEmailTF(),
                      SizedBox(height: 28.0),
                      _buildSenhaTF(),
                      _buildEsqueceuSenhaBtn(),
                      _buildLembrarAcessoCheckBox(),
                      _buildLoginBtn(),
                      _buildCadastrarBtn()
                    ],
                  ),
                ),
              ))
          ),
          Center(
            child: Text("teste5")
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
}

