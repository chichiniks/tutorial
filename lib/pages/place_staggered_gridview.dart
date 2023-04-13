import 'package:flutter/material.dart';
import 'package:fellowship/pages/place.dart';
import 'package:fellowship/pages/place_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PlaceStaggeredGridView extends StatelessWidget {
  final placeList = Place.generatePlaces();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: placeList.length,
              itemBuilder: (context, index) => PlaceItem(placeList[index]),
            ),
          )
        ]
      )





      // child: StaggeredGridTile.count(
      //   shrinkWrap:true,
      //   physics: ScrollPhysics(),
      //   crossAxisSpacing:16,
      //   mainAxisSpacing: 16,
      //   itemCount: placeList.length,
      //   crossAxisCount: 4,
      //   itemBuilder: (context, index) => PlaceItem(placeList[index]),
      //   staggeredTileBuilder: (_) => StaggeredGridTile.fit(2)),
    );
  }
}