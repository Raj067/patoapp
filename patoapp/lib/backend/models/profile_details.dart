class ProfileData {
  int id;
  String businessName;
  String? businessEmail;
  String businessAddress;
  String? instagramName;
  String? businessType;
  String? businessCategory;
  String? instagramSlogan;
  ProfileData({
    required this.id,
    required this.businessName,
    this.businessEmail,
    required this.businessAddress,
    this.instagramName,
    this.businessType,
    this.businessCategory,
    this.instagramSlogan,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessName': businessName,
      'businessAddress': businessAddress,
      'businessEmail': businessEmail,
      'instagramName': instagramName,
      'businessType': businessType,
      'businessCategory': businessCategory,
      'instagramSlogan': instagramSlogan,
    };
  }
}
