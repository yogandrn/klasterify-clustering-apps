import 'dart:convert';

List<Product> listProductFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String listProductToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Product productFromJson(String str) => Product.fromJson(json.decode(str));

class Product {
  int cluster;
  num countReview;
  String id;
  String imageUrl;
  String location;
  String name;
  num price;
  num ratingScore;
  String seller;
  num sold;
  String url;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.price = 0,
    this.sold = 0,
    this.ratingScore = 0,
    this.countReview = 0,
    required this.seller,
    required this.location,
    required this.url,
    this.cluster = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        cluster: json["cluster"],
        countReview: json["count_review"],
        id: json["id"],
        imageUrl: json["image_url"],
        location: json["location"],
        name: json["name"],
        price: json["price"],
        ratingScore: json["rating_score"]?.toDouble(),
        seller: json["seller"],
        sold: json["sold"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "cluster": cluster,
        "count_review": countReview,
        "id": id,
        "image_url": imageUrl,
        "location": location,
        "name": name,
        "price": price,
        "rating_score": ratingScore,
        "seller": seller,
        "sold": sold,
        "url": url,
      };
}
