class Product {
  String? title;
  String? subtitle;
  String? price;
  String? detailUrl;

  Product(this.title, this.subtitle, this.price, this.detailUrl);

  static List<Product> generateProduct() {
    return [
      Product(
          'Gucci oversize',
          'Hoodie',
          '\$79.99',
          'assets/images/hoodie.webp')
    ];
  }
}
