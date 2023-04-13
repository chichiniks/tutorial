import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MySquare extends StatelessWidget {
  // final String child;
  // String title;
  String imageUrl;
  String title;

  MySquare(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 200,
      height: 275,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          image: DecorationImage(
            image: AssetImage(this.imageUrl),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.teal,
          )),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {

          },
          child: Text(
          this.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
        )],),

      );
  }
}

class MySaveSquare extends StatelessWidget {
  // final String child;
  // String title;
  String imageUrl;
  String title;

  MySaveSquare(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          image: DecorationImage(
            image: AssetImage(this.imageUrl),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.teal,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {

            },
            child: Text(
              this.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
              ),),
          )],),

    );
  }
}