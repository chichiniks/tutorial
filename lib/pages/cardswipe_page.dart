import 'package:fellowship/pages/util/card_provider.dart';
import 'package:fellowship/pages/util/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';


class SwipePage extends StatefulWidget {
    const SwipePage({Key? key}) : super(key: key);
    
    @override
    _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
        @override
        Widget build(BuildContext context) {
          return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white
              ]
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
                  body: SafeArea(
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16),
                          child: Column(
                          children: [
                            buildTopButtons(),
                            const SizedBox(height: 16),
                            Expanded(child: buildCards()),
                            const SizedBox(height: 16),
                            buildButtons(), 
                            ], 
                          ),
                      ),
                  ),
              ),

        );
        }


        Widget buildCards() {
            final provider = Provider.of<CardProvider>(context);
            final urlImages = provider.urlImages;


            return urlImages.isEmpty
              ? Center(
              child: ElevatedButton(
              child: Text('Restart'),
              onPressed: () {
                final provider =
                    Provider.of<CardProvider> (context, listen: false);

              provider.resetUsers();
              },
              ))
        :  FlipCard(
                direction: FlipDirection.VERTICAL,
        //front
                front:Stack(
            children: urlImages
                .map((urlImage)  =>
                TinderCard(
                urlImage: urlImage['image'],
                isFront: urlImages.last == urlImage,
                address: urlImage['address'],
                name: urlImage['name'],
                category: urlImage['categories'],
                review_count: urlImage['review_count'],
                  review: urlImage['review'],
                  hours: urlImage['hours']

            ))
                .toList(),
            ),
            back:
            Stack(
            children: urlImages
                .map((urlImage)  => BackCard(
                urlImage: urlImage['image'],
                review: urlImage['review'],
                hours: urlImage['hours']
            ))
                .toList(),

            ),
          );
            ;
    }

    Widget buildTopButtons()  => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.teal[900]
        ),
        child: const Text("New Search", style: TextStyle(color: Colors.white)),
      ),
      OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 70, 21, 55)
        ),
        child: const Text("Saving", style: TextStyle(color: Colors.white)),
      ),
      ]
    );

    Widget buildButtons(){
      final provider= Provider.of<CardProvider>(context);
      final urlImages = provider.urlImages;

      return urlImages.isEmpty
      ? ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Restart',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          final provider =
            Provider.of<CardProvider>(context, listen: false);
          provider.resetUsers();
        },
      )
      : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
          MaterialButton(
            height: 65,
            color: Color.fromARGB(255, 151, 109, 151),
            shape: CircleBorder(),
            child: Icon(Icons.clear, color :Color.fromARGB(255, 84, 19, 70), size: 45),
            onPressed: () {
              final provider =
              Provider.of<CardProvider>(context, listen: false);

            provider.dislike();  
            },
            ),

          MaterialButton(
            height: 65,
            color: Color.fromARGB(255, 107, 125, 107),
            shape: CircleBorder(),
            child: Icon(Icons.check, color :Color.fromARGB(255, 27, 74, 29), size: 45),
            onPressed: () {
              final provider =
              Provider.of<CardProvider>(context, listen: false);

            provider.save();
            },
            ),    
        ],
      );
    }
}
