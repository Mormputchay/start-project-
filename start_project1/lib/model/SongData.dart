class SongData {
  bool success;
  Data data;
  String message;

  SongData({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SongData.fromJson(Map<String, dynamic> json) => SongData(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );
}

class Data {
  List<dynamic> banners;
  List<SongElement> songs;
  List<Product> products;

  Data({
    required this.banners,
    required this.songs,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        banners: List<dynamic>.from(json["banners"].map((x) => x)),
        songs: List<SongElement>.from(
            json["songs"].map((x) => SongElement.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );
}

class Product {
  int id;
  String name;
  String image;
  String description;
  String categoryId;
  dynamic videoUrl;
  String? attribute;
  int productType;
  dynamic? rate;
  String minPrice;
  String maxPrice;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.videoUrl,
    required this.attribute,
    required this.productType,
    required this.rate,
    required this.minPrice,
    required this.maxPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        categoryId: json["category_id"],
        videoUrl: json["video_url"],
        attribute: json["attribute"],
        productType: json["product_type"],
        rate: json["rate"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
      );
}

class SongElement {
  int id;
  String title;
  String artist;
  String production;
  String image;
  int viewCount;

  SongElement({
    required this.id,
    required this.title,
    required this.artist,
    required this.production,
    required this.image,
    required this.viewCount,
  });

  factory SongElement.fromJson(Map<String, dynamic> json) => SongElement(
        id: json["id"],
        title: json["title"],
        artist: json["artist"],
        production: json["production"],
        image: json["image"],
        viewCount: json["view_count"],
      );
}
