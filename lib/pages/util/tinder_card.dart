import 'dart:ffi';
import 'dart:math';
import 'package:fellowship/pages/util/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//back
class BackCard extends StatefulWidget{
  final String review;
  final String hours;
  final String urlImage;

  const BackCard({
    Key? key,
    required this.urlImage,
    required this.review,
    required this.hours,

  }) :super(key: key);
  @override
  State<BackCard> createState() => _BackCardState();
}

class _BackCardState extends State<BackCard> {
  @override
  Widget build(BuildContext context) {
    return buildBackCard();
  }
  Widget buildBackCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color.fromARGB(255, 27, 74, 29)),
                image: DecorationImage(
                  image: AssetImage(widget.urlImage),
                  fit: BoxFit.cover,
                  alignment: Alignment(-0.3,0),
                )
            )
        ),
        Container(
          height: 225,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 27, 74, 29)),
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 195),
              Align(
                alignment: Alignment.centerLeft,
              ),
              // OutlinedButton(
              //   onPressed: null,
              //   style: OutlinedButton.styleFrom(
              //     backgroundColor: Colors.teal[900],
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(18.0),
              //     ),
              //   ),
              //   child:  Text(widget.hours, style: TextStyle(color: Colors.white)),
              // ),
              SizedBox(height: 20),
              Text("Hours", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Text(widget.hours, style: TextStyle(fontSize: 10)),
              Text("Top Review", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Text(widget.review.toString() ,
                  style: TextStyle(fontSize: 10)),

            ],
          ),
        )
      ],
    ),
  );

}

//front
class TinderCard extends StatefulWidget{
  final String urlImage;
  final bool isFront;
  final String address;
  final String name;
  final String category;
  final int review_count;
  final String review;
  final String hours;

  const TinderCard({
    Key? key,
    required this.urlImage,
    required this.isFront,
    required this.address,
    required this.name,
    required this.category,
    required this.review_count,
    required this.review,
    required this.hours,

  }) :super(key: key);
  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: widget.isFront ? buildFrontCard() : buildCard(),
  );

  Widget buildFrontCard() => GestureDetector(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        final milliseconds = provider.isDragging ? 0 : 400;

        final center = constraints.smallest.center(Offset.zero);
        final angle = provider.angle * pi / 180;
        final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: milliseconds),
          transform: rotatedMatrix
          ..translate(position.dx, position.dy),
          child: Stack(
            children: [
              buildCard(),
              buildStamps(),
          ],
          ),
        );
      },
    ),
    onPanStart: (details){
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.startPosition(details);
    },
    onPanUpdate: (details){
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.updatePosition(details);
    },
    onPanEnd: (details){
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.endPosition();
    },
  );

  Widget buildCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color.fromARGB(255, 27, 74, 29)),
            image: DecorationImage(
              image: AssetImage(widget.urlImage),
              fit: BoxFit.cover,
              alignment: Alignment(-0.3,0),
            )
        )
  ),
        Container(
          height: 225,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 27, 74, 29)),
            color: Colors.white,
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(height: 195),
            Align(
            alignment: Alignment.centerLeft,
            child:
              Text(widget.name,
                  style: TextStyle(fontSize: 25)),
            ),
              OutlinedButton(
                onPressed: null,
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.teal[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child:  Text(widget.category, style: TextStyle(color: Colors.white)),
              ),
              Text(widget.review_count.toString() + " people reviewed this location",
                  style: TextStyle(fontSize: 18)),
              Text(widget.address,
                  style: TextStyle(fontSize: 18))
            ],
          ),
        )
      ],
    ),
    );

  Widget buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();

    switch (status) {
      case CardStatus.save:

        final child = buildStamp(angle: -0.5, color: Colors.green, text: 'Save',
            opacity: opacity);
        return Positioned(top: 64, left: 50, child :child);

      case CardStatus.dislike:
        final child = buildStamp(color: Colors.purple, text: 'Dislike',
            opacity: opacity);
        return Positioned(top: 64, left: 50, child :child);

        default:
          return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required String text,
    required double opacity,
}) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 4),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
