class MyCart {
  final String image;
  final String title;
  final String? subtitle;
  final int price;
  int counter;

  MyCart(
      {required this.image,
      required this.title,
      this.subtitle,
      required this.price,
      required this.counter});
}
