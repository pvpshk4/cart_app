import '../../models/product.dart';

class ProductRepository {
  List<Product> getProducts() {
    return [
      Product(
          id: 1,
          name: "Чипсы",
          imageUrl: "https://placehold.co/100x150.png",
          price: 100.0),
      Product(
          id: 2,
          name: "Яблоки",
          imageUrl: "https://placehold.co/100x150.png",
          price: 120.0),
      Product(
          id: 3,
          name: "Бананы",
          imageUrl: "https://placehold.co/100x150.png",
          price: 80.0),
      Product(
          id: 4,
          name: "Молоко",
          imageUrl: "https://placehold.co/100x150.png",
          price: 60.0),
      Product(
          id: 5,
          name: "Чипсы",
          imageUrl: "https://placehold.co/100x150.png",
          price: 500.0),
      Product(
          id: 6,
          name: "Чипсы",
          imageUrl: "https://placehold.co/100x150.png",
          price: 60.0),
      Product(
          id: 7,
          name: "Чипсы",
          imageUrl: "https://placehold.co/100x150.png",
          price: 60.0),
      Product(
          id: 8,
          name: "Чипсы",
          imageUrl: "https://placehold.co/100x150.png",
          price: 60.0),
    ];
  }
}
