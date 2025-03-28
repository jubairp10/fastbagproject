class Store {
  final int id;
  final String businessName;
  final String openingTime;
  final String displayImage;
  bool isFavorite; // Non-nullable boolean

  Store({
    required this.id,
    required this.businessName,
    required this.openingTime,
    required this.displayImage,
    this.isFavorite = false, // Default value
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      businessName: json['business_name'],
      openingTime: json['opening_time'],
      displayImage: json['display_image'],
      isFavorite: json['is_favorite'] ?? false, // Default to false if null
    );
  }
}
