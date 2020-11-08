import 'dart:convert';
import 'package:besafehealthcare/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:date_format/date_format.dart'; 

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

//Classe da página de cadastro
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String nome;
  String senha;
  String email;
  DateTime dataNascimento;
  String cpf;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



//LOGIN
  _cadastroRequest() async {
    // set up POST request arguments
    String url = 'https://vendasprojeto.herokuapp.com/authenticate';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"nome": "${nome}","email": "${email}","senha": "${senha}","dataNascimento": "${dataNascimento},"cpf": "${maskFormatterCPF.getUnmaskedText()}"}';
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
      
    }
    //Error
    if (statusCode == 401) {
       Fluttertoast.showToast(
              msg: "Este e-mail já está em uso",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
    }
    if (statusCode == 400) {
       Fluttertoast.showToast(
              msg: "Este CPF já está em uso",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
    }
  }

  var maskFormatterCPF = new MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'E-mail',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.amber,
              ),
              hintText: 'E-mail',
              hintStyle: kHintTextStyle,
            ),
          validator: (String value) {
            if (value.isEmpty) {
              return 'E-mail é obrigatório';
            }
            if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Insira um e-mail válido';
            }
            return null;
          },
            onSaved: (String value) {
              email = value;
            },
          ),
        )
      ],
    );
  }

 Widget _buildNomeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nome',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_pin,
                color: Colors.amber,
              ),
              hintText: 'Nome completo',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
            onSaved: (String value) {
              nome = value;
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
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.amber,
              ),
              hintText: 'Crie uma senha',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Senha é obrigatório';
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

  Widget _buildCPFTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CPF',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [maskFormatterCPF],
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.looks_one,
                color: Colors.amber,
              ),
              hintText: 'CPF',
              hintStyle: kHintTextStyle,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'CPF é obrigatório';
              }
              return null;
            },
            onSaved: (String value) {
              email = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildDateTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Data de Nascimento',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.amber,
              ),
              hintText: 'Data de Nascimento',
              hintStyle: kHintTextStyle,
          ),
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: dataNascimento == null ? DateTime.now() : dataNascimento,
                    firstDate: DateTime(1920),
                    lastDate: DateTime(2021))
                .then((date) { 
              setState(() {
                dataNascimento = date;
              print(dataNascimento);
              });
            });
          },
          controller: TextEditingController(text: (dataNascimento == null ? '' : formatDate(dataNascimento, [dd, '/', mm, '/', yyyy]))),
        )
        )
      ],
    );
  }


  Widget _buildSaveBtn() {
    return Container(
      padding: EdgeInsets.only(top: 35.0, bottom: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          //_cadastroRequest();
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        },
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text('CADASTRAR',
            style: TextStyle(
                color: Colors.green,
                letterSpacing: 2.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
          child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Cadastro',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: 30.0),
                      _buildNomeTF(),
                      SizedBox(height: 20.0),
                      _buildCPFTF(),
                      SizedBox(height: 20.0),
                      _buildDateTF(),
                      SizedBox(height: 20.0),
                      _buildEmailTF(),
                      SizedBox(height: 20.0,),
                      _buildSenhaTF(),
                      _buildSaveBtn()
                    ],
                  ),
                ),
              ))
        ),
        )
      );
  }
}
