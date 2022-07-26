class ProfileData {
  int id;
  String businessName;
  String businessEmail;
  String businessPhone;
  String businessAddress;
  String instagramName;
  String businessType;
  String businessCategory;
  String businessSlogan;
  String businessLogo;
  String businessSignature;
  ProfileData({
    required this.id,
    required this.businessName,
    this.businessEmail = "",
    this.businessAddress = "",
    this.businessPhone = "",
    this.instagramName = "",
    this.businessType = "",
    this.businessCategory = "",
    this.businessSlogan = "",
    this.businessLogo = "",
    this.businessSignature = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'businessName': businessName,
      'businessAddress': businessAddress,
      'businessPhone': businessPhone,
      'businessEmail': businessEmail,
      'instagramName': instagramName,
      'businessType': businessType,
      'businessCategory': businessCategory,
      'businessSlogan': businessSlogan,
      'businessLogo': businessLogo,
      'businessSignature': businessSignature,
    };
  }
}
