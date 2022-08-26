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
      'businessName': businessName.toString(),
      'businessAddress': businessAddress.toString(),
      'businessPhone': businessPhone.toString(),
      'businessEmail': businessEmail.toString(),
      'instagramName': instagramName.toString(),
      'businessType': businessType.toString(),
      'businessCategory': businessCategory.toString(),
      'businessSlogan': businessSlogan.toString(),
      'businessLogo': businessLogo.toString(),
      'businessSignature': businessSignature.toString(),
    };
  }
}

ProfileData fromJsonProfile(Map<String, dynamic> profile) {
  return ProfileData(
    instagramName: profile['instagramName'].toString(),
    businessSignature: profile['businessSignature'].toString(),
    businessSlogan: "${profile['businessSlogan']}".toString(),
    businessLogo: profile['businessLogo'].toString(),
    businessCategory: profile['businessCategory'].toString(),
    businessType: profile['businessType'].toString(),
    businessEmail: profile['businessEmail'].toString(),
    businessPhone: "${profile['businessPhone']}".toString(),
    businessAddress: "${profile['businessAddress']}".toString(),
    businessName: "${profile['businessName']}".toString(),
    id: profile['id'],
  );
}
