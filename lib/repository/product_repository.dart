import '../models/product.dart';

class ProductRepository {
  List<Product> getProducts() {
    return [
      Product(
          id: 1,
          name: "Чипсы",
          imageUrl: "https://imgur.com/FDmT2qo.png",
          price: 100.0),
      Product(
          id: 2,
          name: "Чипсы",
          imageUrl: "https://imgur.com/FDmT2qo.png",
          price: 120.0),
      Product(
          id: 3,
          name: "Чипсы",
          imageUrl: "https://imgur.com/FDmT2qo.png",
          price: 80.0),
    ];
  }
}
