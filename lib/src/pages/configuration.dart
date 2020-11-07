import 'package:flutter/material.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.black26, blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Ansiedade', 'iconPath': 'images/headache.png'},
  {'name': 'Depressão', 'iconPath': 'images/sadness.png'},
  {'name': 'Família', 'iconPath': 'images/home.png'},
  {'name': 'Trabalho', 'iconPath': 'images/portfolio.png'},
  {'name': 'Amor', 'iconPath': 'images/heart.png'}
];

List<Map> testelista = [
  {'name': 'Giulia Pagotto', 'profissao': 'Psicóloga', 'valor': '180,00', 'iconPath': 'images/giuliap.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Lucas de Castro', 'profissao': 'Psicólogo', 'valor': '190,00', 'iconPath': 'images/giuliap2.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'João da Silva', 'profissao': 'Psicólogo', 'valor': '110,00', 'iconPath': 'images/giuliap.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Ana Beatriz', 'profissao': 'Psicóloga', 'valor': '200,00', 'iconPath': 'images/giuliap2.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Jorge Almeida', 'profissao': 'Psicólogo', 'valor': '190,00', 'iconPath': 'images/giuliap.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Gabriel Américo', 'profissao': 'Psicólogo', 'valor': '180,00', 'iconPath': 'images/giuliap.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Lucas Junior', 'profissao': 'Psicólogo', 'valor': '190,00', 'iconPath': 'images/giuliap2.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Nicole Andrade', 'profissao': 'Psicóloga', 'valor': '110,00', 'iconPath': 'images/giuliap.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Ana Clara', 'profissao': 'Psicóloga', 'valor': '200,00', 'iconPath': 'images/giuliap2.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'},
  {'name': 'Pedro Pedra', 'profissao': 'Psicólogo', 'valor': '190,00', 'iconPath': 'images/giuliap.jpg', 'descricao': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur'}
];