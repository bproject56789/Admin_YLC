import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final String image;
  const FullScreen({
    Key key,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        leading: Container(),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          image,
          // fit: BoxFit.fill,
        ),
      ),
    );
  }
}
