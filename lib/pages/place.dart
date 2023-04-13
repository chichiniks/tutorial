class Place {
  String title;
  String imageUrl;
  double height;

  Place(this.title, this.imageUrl, this.height);

  static List<Place> generatePlaces() {
    return [
      Place("Reno", 'https://images.unsplash.com/photo-1526512340740-9217d0159da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmVydGljYWx8ZW58MHx8MHx8&w=1000&q=80', 100),
      // Place("Santa Barbara",  100),
      // Place("Tampa",  100),
      // Place("New Orleans",  100),
      // Place("Philadelphia", 100)
    ];
  }
}