import 'package:flutter/material.dart';
import 'package:fellowship/pages/place.dart';

class PlaceItem extends StatelessWidget {
  final Place place;
  PlaceItem(this.place);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          image: DecorationImage(
            image: AssetImage(place.imageUrl),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.teal,
          )),
    );Container(
      alignment: Alignment.bottomLeft,
        height: 240,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(255, 27, 74, 29)),
            image: DecorationImage(
              image: AssetImage(place.imageUrl),
              fit: BoxFit.cover,
            )
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Title',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),)]
      )
    );
  }
}