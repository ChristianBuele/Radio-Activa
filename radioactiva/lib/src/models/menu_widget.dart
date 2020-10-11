import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(203, 8, 42, 1),
            Color.fromRGBO(177, 51, 73, 1)
          ], end: Alignment(0.8, 0.0))),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Container(
                        child: Image.asset('assets/logo.png'),
                      ),
                    ),
                    Text(
                      'Síguenos en nuestras redes',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/f-01.png'),
                ),
                title: Text(
                  'Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'navegador',
                      arguments: 'https://www.facebook.com/radioactivafan');
                  print('FACEBOOK');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/t-01.png'),
                ),
                title: Text(
                  'Twiter',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'navegador',
                      arguments: 'https://twitter.com/radioactivafan');
                  print('Twiter');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/i-01.png'),
                ),
                title: Text(
                  'Instagram',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'navegador',
                      arguments: 'https://www.instagram.com/radioactivafan/');
                  print('FACEBOOK');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ));
  }
}
