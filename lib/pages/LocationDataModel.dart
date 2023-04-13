class LocationDataModel{
  String? business_id;
  String? name;
  String? address;
  String? city;
  int? review_count;
  String? categories;

  LocationDataModel(
      {
        this.business_id,
      this.name,
      this.address,
      this.city,
      this.review_count,
      this.categories
      });
  LocationDataModel.fromJson(Map<String, dynamic> json)
  {
    business_id = json['business_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    review_count = json['review_count'];
    categories = json['categories'];
  }

}
