import 'dart:convert';
import 'dart:math';
import 'package:fellowship/pages/LocationDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CardStatus {dislike, save}

class CardProvider extends ChangeNotifier {
  List<Map> _urlImages = [];
  List<Map> _philly = [];
  List<Map> _reno = [];
  List<Map> _santa = [];
  List<Map> _tampa = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<Map> get urlImages => _urlImages;
  List<Map> get philly => _philly;
  List<Map> get reno => _reno;
  List<Map> get santa => _santa;
  List<Map> get tampa => _tampa;

  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details){
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details){
    _position += details.delta;
    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();

    final status = getStatus(force: true);

    if (status!=null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: status.toString().split('.').last.toUpperCase(),
        fontSize:36,
      );
    }

    switch (status) {
      case CardStatus.save:
        save();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      // case CardStatus.save:
      //   save();
        break;
      default:
        resetPosition();
    }

    resetPosition();

  }

  void resetPosition () {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  double getStatusOpacity() {
    final delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity,1);
  }
  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSave = x.abs() < 20;

    if (force) {
    final delta = 100;
    if (x >= delta) {
      return CardStatus.save;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    }
    // else if (y <= -delta / 2 && forceSave) {
    //   return CardStatus.save;
    // }
  } else {
    final delta = 20;
    // if (y<= -delta * 2 && forceSave) {
    //   return CardStatus.save;
    // }
    if (x>= delta) {
      return CardStatus.save;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    }
  }
  }

    void dislike() {
    _angle = -20;
    _position -= Offset(2* _screenSize.width, 0);
    _nextCard();

    notifyListeners();
    }

    void save() {
      _angle = 20;
      _position += Offset(2 * _screenSize.width, 0);
      _nextCard();

      notifyListeners();
    }


    Future _nextCard() async {
      // if (places.['city'])
      if (_urlImages.isEmpty) return;
      // if (places.iterator.current['city'] != 'hi');

      await Future.delayed(Duration(milliseconds: 200));
      _urlImages.removeLast();

      resetPosition();
    }


    void resetUsers() {
      // _places = <Map>[
      //   {"business_id": "M0XSSHqrASOnhgbWDJIpQA", "name": "Herb Import Co", "address": "712 Adams St", "city": "New Orleans", "review_count": 5, "categories": "Vape Shops, Tobacco Shops, Personal Shopping, Vitamins & Supplements, Shopping"},
      //   {"business_id": "J_ksUDPpzPwfTGtI4zTRnQ", "name": "Riverview Room", "address": "600 Decatur St", "city": "New Orleans", "review_count": 7, "categories": "Event Planning & Services, Caterers, Party & Event Planning"},
      //   {"business_id": "4IcB3QyMEA85UTWFKh9O9A", "name": "Eat Mah Taco @ Pal's Lounge", "address": "949 N Rendon St", "city": "New Orleans", "review_count": 8, "categories": "American (New), Food, Bars, Nightlife, Lounges, Restaurants"},
      //   {"business_id": "jnyHs1ZXy9qIE2gORZBQMg", "name": "Style Lab For Men", "address": "3326 Magazine St", "city": "New Orleans", "review_count": 6, "categories": "Fashion, Men's Clothing, Shopping"},
      //   {"business_id": "IOZrqUQ2Jg6UeQ5CWpsmkg", "name": "Nesbit's Magazine Street Market", "address": "301 Magazine St", "city": "New Orleans", "review_count": 7, "categories": "Convenience Stores, Food, Grocery, Coffee & Tea, Beer, Wine & Spirits"},
      //
      //   {"business_id": "pXb7pDVPayyElIqVlh1FOg", "name": "Brown Chicken Brown Cow", "address": "1321 S 2nd St", "city": "Philadelphia", "review_count": 5, "categories": "Ice Cream & Frozen Yogurt, Coffee & Tea, Food"},
      //   {"business_id": "4NjPz9bJzll1FMIi2bw8HA", "name": "Sonam", "address": "223 South St", "city": "Philadelphia", "review_count": 9, "categories": "Tapas Bars, Restaurants"},
      //   {"business_id": "syB4xhM0hiaib19fucneBA", "name": "B & W Locksmith", "address": "3320 Glenview St", "city": "Philadelphia", "review_count": 6, "categories": "Keys & Locksmiths, Home Services"},
      //   {"business_id": "kCK5pdQCh56eCnWpLcNt9g", "name": "Moday Center for Functional and Integrative Medicine", "address": "110 S 20th St, Ste 400", "city": "Philadelphia", "review_count": 9, "categories": "Health & Medical, Naturopathic/Holistic, Medical Centers, Doctors"},
      //   {"business_id": "2X6HUYGV7Djr_TFX6uYebA", "name": "Philadelphia Sports Network", "address": "", "city": "Philadelphia", "review_count": 7, "categories": "Active Life, Amateur Sports Teams, Arts & Entertainment, Social Clubs, Sports Clubs"},
      //
      //   {"business_id": "WdrpkH-q7FQY5nclmPfoDQ", "name": "Daniel Colombo , MD", "address": "10581 Double R Blvd", "city": "Reno", "review_count": 7, "categories": "Doctors, Pediatricians, Health & Medical"},
      //   {"business_id": "_WRe3ql2DI_h3htr77Siew", "name": "The Office", "address": "248 W 1st St", "city": "Reno", "review_count": 7, "categories": "Nightlife, Lounges, Bars"},
      //   {"business_id": "kKb00Oj96n5YYqMSDzx1IA", "name": "Lush Ink & Skin Studio", "address": "577 South Meadows Pkwy, Ste 6, Reno Breathe Bar", "city": "Reno", "review_count": 6, "categories": "Weight Loss Centers, Health & Medical, Beauty & Spas, Eyelash Service, Skin Care, Permanent Makeup, Cryotherapy"},
      //   {"business_id": "CNVapZiNGgqVrkEwmS8INQ", "name": "Deadline Escape Rooms", "address": "7111 South Virginia St", "city": "Reno", "review_count": 7, "categories": "Active Life, Escape Games, Arts & Entertainment"},
      //   {"business_id": "YQxZzSbGJl_4Ul2EGXYAqQ", "name": "Mount Mogrit Gourmet", "address": "", "city": "Reno", "review_count": 8, "categories": "Food Trucks, Food"},
      //
      //   {"business_id": "TZ-bgvsk189WywTLFrqfTQ", "name": "Ascending Health Juicery", "address": "34 E Sola St", "city": "Santa Barbara", "review_count": 7, "categories": "Food, Health & Medical, Juice Bars & Smoothies"},
      //   {"business_id": "9L-MR0arflwFMF9szEBOOg", "name": "California Wine Festival", "address": "", "city": "Santa Barbara", "review_count": 7, "categories": "Wineries, Food, Restaurants, Arts & Entertainment, Festivals, Food Stands"},
      //   {"business_id": "aYMpjij5ShtEoZueMrQPRw", "name": "The Mill", "address": "406 E Haley St", "city": "Santa Barbara", "review_count": 5, "categories": "Breweries, Shopping, Food Court, Food, Venues & Event Spaces, Restaurants, Event Planning & Services, Wineries, Wine Tasting Room, Arts & Entertainment, Shopping Centers"},
      //   {"business_id": "zliWQ4TXYzcehYQQbeQiYA", "name": "Party Proper Productions", "address": "", "city": "Santa Barbara", "review_count": 7, "categories": "DJs, Event Planning & Services"},
      //   {"business_id": "nTZuJSfwCoNOyA1yS3rbOQ", "name": "The Silver Bough", "address": "1295 Coast Village Rd", "city": "Santa Barbara", "review_count": 7, "categories": "American (New), Restaurants"},
      //
      //   {"business_id": "6PshKI1dII8x4EESe5Y-Rg", "name": "Hott Mess Cafe", "address": "6102 Interbay Blvd", "city": "Tampa", "review_count": 5, "categories": "Tacos, Mexican, Restaurants, American (Traditional), Hot Dogs"}, {"business_id": "KQg6erkB7g5C2fsxz5P1Mw", "name": "Gracie Martial Arts & Self Defense Tampa", "address": "723 W Columbus Dr, Ste B", "city": "Tampa", "review_count": 5, "categories": "Active Life, Fitness & Instruction, Martial Arts"},
      //   {"business_id": "jP3-eeW0phHVgbxbTjfEzA", "name": "VIVIFY Plastic Surgery", "address": "1000 W Kennedy Blvd, Ste 202", "city": "Tampa", "review_count": 8, "categories": "Plastic Surgeons, Doctors, Surgeons, Health & Medical, Cosmetic Surgeons"},
      //   {"business_id": "1WAzkYgF_rTN8kopR8Sxkg", "name": "Stor-N-More Self Storage", "address": "1505 S US Hwy 301", "city": "Tampa", "review_count": 7, "categories": "Local Services, Self Storage"},
      //   {"business_id": "LZ6AGv3Vkgk77DyQmr6FfQ", "name": "Amaro's Body Shop", "address": "3420 W Columbus Dr", "city": "Tampa", "review_count": 7, "categories": "Automotive, Body Shops"},
      //   {"business_id": "q7Jqp1ZduO5GToU4JlsAJw", "name": "Christopher Nejman Hair", "address": "11237 W Linebaugh Ave, Ste 2", "city": "Tampa", "review_count": 7, "categories": "Hair Salons, Beauty & Spas, Hair Stylists"}, {"business_id": "mVMR2nvy96Jrl0Aqa8NeBg", "name": "Sabor del Caribe", "address": "7699 W Waters Ave", "city": "Tampa", "review_count": 8, "categories": "Puerto Rican, Food, Street Vendors, Food Trucks, Restaurants, Caribbean"},
      // ].reversed.toList();
      _urlImages = <Map>[
        {"image": "assets/eat_mah.jpg","business_id": "4IcB3QyMEA85UTWFKh9O9A", "name": "Eat Mah Taco @ Pal's Lounge", "address": "949 N Rendon St", "city": "New Orleans", "review_count": 8, "categories": "American (New), Food, Bars, Nightlife, Lounges, Restaurants", "hours": "Mon : Closed\nTuesday 5:00PM - 10:00PM\nWed : Closed\nThu : Closed\nFri : Closed\nSat : Closed\nSun : Closed\n", "review": "We went on a Friday evening. 2/10/23 We walked in & no hostess at the door. Took a minute to be seated. But the place was PACKED!"},
        {"image": "assets/style_lab.jpg", "business_id": "jnyHs1ZXy9qIE2gORZBQMg", "name": "Style Lab For Men", "address": "3326 Magazine St", "city": "New Orleans", "review_count": 6, "categories": "Fashion, Men's Clothing, Shopping", "hours": "Mon : 11:00 AM - 6:00 PM\nTuesday : 11:00 AM - 6:00 PM\nWed : 11:00 AM - 6:00 PM\nThu : 11:00 AM - 6:00 PM\nFri : 11:00 AM - 6:00 PM\nSat : 11:00 AM - 6:00 PM\nSun : 12:00 PM - 5:00 PM\n", "review": "If you want to avoid Saks at Canal Place, Style Lab on Magazine Street is 100% the place to go for high end casual menswear. "},
        {"image": "assets/nesbit.jpg", "business_id": "IOZrqUQ2Jg6UeQ5CWpsmkg", "name": "Nesbit's Magazine Street Market", "address": "301 Magazine St", "city": "New Orleans", "review_count": 7, "categories": "Convenience Stores, Food, Grocery, Coffee & Tea, Beer, Wine & Spirits", "hours": "Mon : 8:00 AM - 10:00 PM\nTuesday : 8:00 AM - 10:00 PM\nWed : 8:00 AM - 10:00 PM\nThu : 8:00 AM - 10:00 PM\nFri : 8:00 AM - 10:00 PM\nSat : 9:00 AM - 10:00 PM\nSun : 9:00 AM - 10:00 PM\n", "review": "This market is adorable. They offer so many of the things you may need in a pinch."},
        {"image": "assets/bcbc.png", "business_id": "pXb7pDVPayyElIqVlh1FOg", "name": "Brown Chicken Brown Cow", "address": "1321 S 2nd St", "city": "Philadelphia", "review_count": 5, "categories": "Ice Cream & Frozen Yogurt, Coffee & Tea, Food", "hours": "Mon : 9:00 AM - 5:00 PM\nTuesday : 11:00 AM - 6:00 PM\nWed : 12:00 PM - 9:00 PM\nThu : 12:00 PM - 9:00 PM\nFri : 12:00 PM - 9:00 PM\nSat : 12:00 PM - 9:00 PM\nSun : 12:00 PM - 9:00 PM\n", "review": "For the price, I expected a bigger beef patty that didn't get lost in the bun. Without a doubt overpriced for what it is. "},
        {"image": "assets/sonam.jpg", "business_id": "4NjPz9bJzll1FMIi2bw8HA", "name": "Sonam", "address": "223 South St", "city": "Philadelphia", "review_count": 9, "categories": "Tapas Bars, Restaurants", "hours": "Mon : 9:00 AM - 5:00 PM\nTuesday : 11:00 AM - 6:00 PM\nWed : 10:00 AM - 5:00 PM\nThu : 9:00 AM - 5:00 PM\nFri : 9:00 AM - 9:00 PM\nSat : 9:00 AM - 5:00 PM\nSun : 12:00 PM - 5:00 PM\n", "review": "You may recognize the location (it's been a bunch of different restaurants over the past few years) but this time, the food is worth coming back for."},
        {"image": "assets/bw.png", "business_id": "syB4xhM0hiaib19fucneBA", "name": "B & W Locksmith", "address": "3320 Glenview St", "city": "Philadelphia", "review_count": 6, "categories": "Keys & Locksmiths, Home Services", "hours": "Mon : 9:00 AM - 5:00 PM\nTuesday : 11:00 AM - 6:00 PM\nWed : 9:00 AM - 5:00 PM\nThu : 9:00 AM - 5:00 PM\nFri : 9:00 AM - 5:00 PM\nSat : 9:00 AM - 5:00 PM\nSun : 12:00 PM - 5:00 PM\n", "review": "I would give even more stars if I could! B & W Locksmith was the only company that actually knew what they were doing."},
        {"image": "assets/deadline.jpg", "business_id": "CNVapZiNGgqVrkEwmS8INQ", "name": "Deadline Escape Rooms", "address": "7111 South Virginia St", "city": "Reno", "review_count": 7, "categories": "Active Life, Escape Games, Arts & Entertainment", "hours": "Mon : 11:00 AM - 6:00 PM\nTuesday : 11:00 AM - 6:00 PM\nWed : 11:00 AM - 6:00 PM\nThu : 11:00 AM - 6:00 PM\nFri : 11:00 AM - 6:00 PM\nSat : 11:00 AM - 6:00 PM\nSun : 12:00 PM - 5:00 PM\n", "review": "So much fun and the rooms are so fun to play! Definitely recommend to anyone who wants to have a good time!"},
        {"image": "assets/mmg.jpg", "business_id": "YQxZzSbGJl_4Ul2EGXYAqQ", "name": "Mount Mogrit Gourmet", "address": "324 Vallejo St", "city": "Reno", "review_count": 8, "categories": "Food Trucks, Food", "hours": "Mon : 11:00 AM - 6:00 PM\nTuesday : 11:00 AM - 6:00 PM\nWed : 11:00 AM - 6:00 PM\nThu : 11:00 AM - 6:00 PM\nFri : 11:00 AM - 6:00 PM\nSat : 11:00 AM - 6:00 PM\nSun : 12:00 PM - 5:00 PM\n", "review": "The blue slaw, Monterey  jack polenta, and teriyaki chicken sandwich were amazing, great favor!!!"},
        {"image": "assets/office.jpg", "business_id": "_WRe3ql2DI_h3htr77Siew", "name": "The Office", "address": "248 W 1st St", "city": "Reno", "review_count": 7, "categories": "Nightlife, Lounges, Bars", "hours": "Mon : 4:30 PM - 11:30 PM\nTuesday : 4:30 PM - 11:30 PM\nWed : 4:30 PM - 11:30 PM\nThu : 4:30 PM - 11:30 PM\nFri : 4:30 PM - 2:00 AM\nSat : 2:00 PM - 2:00 AM\nSun : 4:30 PM - 11:30 PM\n", "review" : "This unassuming bar on First Street is worth a visit! It feels like sitting  in someone's hope. It's usually not too crowded or loud so you can have a conversation."},
        {"image": "assets/ahj.jpg", "business_id": "TZ-bgvsk189WywTLFrqfTQ", "name": "Ascending Health Juicery", "address": "34 E Sola St", "city": "Santa Barbara", "review_count": 7, "categories": "Food, Health & Medical, Juice Bars & Smoothies", "hours": "Mon : Closed\nTuesday 5:00PM - 10:00PM\nWed : Closed\nThu : Closed\nFri : Closed\nSat : Closed\nSun : Closed\n", "review": "You can't go wrong with Ascending Health Juicery, and I recommend it very much."},
        {"image": "assets/cawf.png", "business_id": "9L-MR0arflwFMF9szEBOOg", "name": "California Wine Festival", "address": "", "city": "Santa Barbara", "review_count": 7, "categories": "Wineries, Food, Restaurants, Arts & Entertainment, Festivals, Food Stands", "hours": "Mon : 9:00 AM - 5:00 PM\nTuesday 9:00 AM - 5:00 PM\nWed : 9:00 AM - 5:00 PM\nThu : 9:00 AM - 5:00 PM\nFri : 9:00 AM - 5:00 PM\nSat : Closed\nSun : Closed\n", "review": "I've always wanted to attend the California Wine Festival and I'm so happy I finally had the opportunity to make it! This event is a must for anyone that loves wine tasting."},
        {"image": "assets/themill.jpg", "business_id": "aYMpjij5ShtEoZueMrQPRw", "name": "The Mill", "address": "406 E Haley St", "city": "Santa Barbara", "review_count": 5, "categories": "Breweries", "hours": "Mon : 10:00 PM - 12:00 AM\nTuesday : 10:00 PM - 12:00 AM\nWed : 10:00 PM - 12:00 AM\nThu : 10:00 PM - 12:00 AM\nFri : 10:00 PM - 12:00 AM\nSat : 10:00 PM - 12:00 AM\nSun : 10:00 PM - 12:00 AM\n", "review": "The Mill has come a long way over COVID. The Winery and Brewery now feel cohesive. You can order food at both spots and drink what you like in the courtyard! Love it! The atmosphere and vibe is fun and chill!"},
      ];
      urlImages.shuffle();


      // _philly = <Map>[
      //   {"image": "assets/bcbc.png", "business_id": "pXb7pDVPayyElIqVlh1FOg", "name": "Brown Chicken Brown Cow", "address": "1321 S 2nd St", "city": "Philadelphia", "review_count": 5, "categories": "Ice Cream & Frozen Yogurt, Coffee & Tea, Food"},
      //   {"image": "assets/sonam.jpg", "business_id": "4NjPz9bJzll1FMIi2bw8HA", "name": "Sonam", "address": "223 South St", "city": "Philadelphia", "review_count": 9, "categories": "Tapas Bars, Restaurants"},
      //   {"image": "assets/bw.png", "business_id": "syB4xhM0hiaib19fucneBA", "name": "B & W Locksmith", "address": "3320 Glenview St", "city": "Philadelphia", "review_count": 6, "categories": "Keys & Locksmiths, Home Services"},
      // ].reversed.toList();
      //
      // _reno = <Map>[
      //   {"image": "assets/deadline.jpg", "business_id": "CNVapZiNGgqVrkEwmS8INQ", "name": "Deadline Escape Rooms", "address": "7111 South Virginia St", "city": "Reno", "review_count": 7, "categories": "Active Life, Escape Games, Arts & Entertainment"},
      //   {"image": "assets/mmg.jpg", "business_id": "YQxZzSbGJl_4Ul2EGXYAqQ", "name": "Mount Mogrit Gourmet", "address": "324 Vallejo St", "city": "Reno", "review_count": 8, "categories": "Food Trucks, Food"},
      //   {"image": "assets/office.jpg", "business_id": "_WRe3ql2DI_h3htr77Siew", "name": "The Office", "address": "248 W 1st St", "city": "Reno", "review_count": 7, "categories": "Nightlife, Lounges, Bars"},
      //   ].reversed.toList();
      //
      // _santa = <Map>[
      //   {"image": "assets/ahj.jpg", "business_id": "TZ-bgvsk189WywTLFrqfTQ", "name": "Ascending Health Juicery", "address": "34 E Sola St", "city": "Santa Barbara", "review_count": 7, "categories": "Food, Health & Medical, Juice Bars & Smoothies"},
      //   {"image": "assets/cawf.jpg", "business_id": "9L-MR0arflwFMF9szEBOOg", "name": "California Wine Festival", "address": "", "city": "Santa Barbara", "review_count": 7, "categories": "Wineries, Food, Restaurants, Arts & Entertainment, Festivals, Food Stands"},
      //   {"image": "assets/themill.jpg", "business_id": "aYMpjij5ShtEoZueMrQPRw", "name": "The Mill", "address": "406 E Haley St", "city": "Santa Barbara", "review_count": 5, "categories": "Breweries, Shopping, Food Court, Food, Venues & Event Spaces, Restaurants, Event Planning & Services, Wineries, Wine Tasting Room, Arts & Entertainment, Shopping Centers"},
      // ].reversed.toList();

      notifyListeners();
    }

    // Future<List<LocationDataModel>>ReadJsonData() async{
    //   final jsondata = await rootBundle.rootBundle.loadString('reno.json');
    //   final list = json.decode(jsondata) as List<dynamic>;
    //
    //   return list.map((e) => LocationDataModel.fromJson(e)).toList();
    //


    }




