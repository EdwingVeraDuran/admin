class Brand {
  final String? id;
  final String name;

  Brand({this.id, required this.name});

  Map<String, dynamic> toMap() => {'name': name};

  factory Brand.fromMap(Map<String, dynamic> map) =>
      Brand(id: map['id'], name: map['name']);
}
