class TicketType {
  String name;
  double price;
  int quantity;
  String? description;

  TicketType({
    required this.name,
    required this.price,
    required this.quantity,
    this.description,
  });
}

