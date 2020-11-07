import 'dart:ui';

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget{
  final String nome;
  final String profissao;
  final String imagem;
  final String descricao;

  const DetailsScreen({Key key, this.nome, this.profissao, this.imagem, this.descricao}) : super(key: key);
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
          child: Column(
            children: [
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child:  Image.asset(this.imagem, fit: BoxFit.fitWidth,),
            ),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: -23),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24)
                )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                          height: 55,
                          width: 55,
                          margin: EdgeInsets.only(
                            top: -62,
                            right: -245
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber
                          ),
                          child: Icon(Icons.chat_rounded, color: Colors.white)
                      )
                      ])),
                      Text(this.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                      SizedBox(height: 5,),
                      Text(this.profissao, style: TextStyle(fontSize: 17), textAlign: TextAlign.left,),
                      SizedBox(height: 40,),
                      Text(this.descricao, style: TextStyle(fontSize: 16, color: Colors.grey,), textAlign: TextAlign.justify,)
                    ],),
                  )
                ],)
              )
            ],
          ),
        ),
        )
      ),
    );
  }
}