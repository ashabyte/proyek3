class CartItem {
  final String id;
  final String title;
  final String location;
  final String datetime;
  final int price;
  bool isSelected;

  CartItem({
    required this.id,
    required this.title,
    required this.location,
    required this.datetime,
    required this.price,
    this.isSelected = true,
  });
}