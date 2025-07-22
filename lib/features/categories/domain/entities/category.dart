class Category {
  final String? id;
  final String name;

  Category({this.id, required this.name});

  Map<String, dynamic> toMap() => {'name': name};

  factory Category.fromMap(Map<String, dynamic> map) =>
      Category(id: map['id'], name: map['name']);
}
