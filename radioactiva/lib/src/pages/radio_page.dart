import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        alignment: Alignment(50, 50),
        //padding: EdgeInsets.only(top: 100.0),
        //  margin: EdgeInsets.only(top: 90.0),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/fondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        /* add child content content here */
      ),
    );
  }

  crear() {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'prueba',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(''),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
