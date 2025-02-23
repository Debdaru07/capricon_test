class AuthResponse {
  final String jwt;
  final User user;

  AuthResponse({
    required this.jwt,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      jwt: json['jwt'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jwt': jwt,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String investorType;
  final String? fcmToken;
  final String? mobileNo;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? resetPasswordOtp;
  final DateTime? deletedAt;
  final String? externalProfilePictureUrl;
  final String? addressLine1;
  final String? addressLine2;
  final String fullName;
  final bool? ibkrOnboardingFinished;
  final bool? guidedInvestingFinished;
  final bool? customiseClimatePortfolio;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    required this.investorType,
    this.fcmToken,
    this.mobileNo,
    this.city,
    this.state,
    this.zipCode,
    this.resetPasswordOtp,
    this.deletedAt,
    this.externalProfilePictureUrl,
    this.addressLine1,
    this.addressLine2,
    required this.fullName,
    this.ibkrOnboardingFinished,
    this.guidedInvestingFinished,
    this.customiseClimatePortfolio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      provider: json['provider'] as String,
      confirmed: json['confirmed'] as bool,
      blocked: json['blocked'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      investorType: json['investor_type'] as String,
      fcmToken: json['fcm_token'] as String?,
      mobileNo: json['mobile_no'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
      resetPasswordOtp: json['reset_password_otp'] as String?,
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at'] as String) : null,
      externalProfilePictureUrl: json['external_profile_picture_url'] as String?,
      addressLine1: json['address_line_1'] as String?,
      addressLine2: json['address_line_2'] as String?,
      fullName: json['full_name'] as String,
      ibkrOnboardingFinished: json['ibkr_onboarding_finished'] as bool?,
      guidedInvestingFinished: json['guided_investing_finished'] as bool?,
      customiseClimatePortfolio: json['customise_climate_portfolio'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'investor_type': investorType,
      'fcm_token': fcmToken,
      'mobile_no': mobileNo,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      'reset_password_otp': resetPasswordOtp,
      'deleted_at': deletedAt?.toIso8601String(),
      'external_profile_picture_url': externalProfilePictureUrl,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'full_name': fullName,
      'ibkr_onboarding_finished': ibkrOnboardingFinished,
      'guided_investing_finished': guidedInvestingFinished,
      'customise_climate_portfolio': customiseClimatePortfolio,
    };
  }
}