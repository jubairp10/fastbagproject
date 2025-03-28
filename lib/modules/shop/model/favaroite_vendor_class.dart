class FavoriteVendor {
  final String businessName;
  final String openingTime;
  final String displayImage;
  final String closingTime;

  FavoriteVendor({
    required this.businessName,
    required this.openingTime,
    required this.displayImage,
    required this.closingTime,
  });

  factory FavoriteVendor.fromJson(Map<String, dynamic> json) {
    return FavoriteVendor(
      businessName: json['business_name'],
      openingTime: json['opening_time'],
      displayImage: json['display_image'],
      closingTime: json['closing_time'],
    );
  }
}
