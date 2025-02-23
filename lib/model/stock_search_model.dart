class StockSearchModel {
  final int id;
  final String name;
  final String symbol;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String alpacaId;
  final String exchange;
  final String? description;
  final String assetType;
  final String? isin;
  final String? industry;
  final String? sector;
  final int? employees;
  final String? website;
  final String? address;
  final double? netZeroProgress;
  final double? carbonIntensityScope3;
  final double? carbonIntensityScope1And2;
  final double? carbonIntensityScope1And2And3;
  final String? tempAlignmentScopes1And2;
  final bool? dnshAssessmentPass;
  final bool? goodGovernanceAssessment;
  final bool? contributeToEnvironmentOrSocialObjective;
  final bool? sustainableInvestment;
  final double? scope1Emissions;
  final double? scope2Emissions;
  final double? scope3Emissions;
  final double? totalEmissions;
  final String? listingDate;
  final String? marketCap;
  final int? ibkrConnectionId;
  final StockImage? image;
  final User? createdBy;
  final User? updatedBy;

  StockSearchModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.alpacaId,
    required this.exchange,
    this.description,
    required this.assetType,
    this.isin,
    this.industry,
    this.sector,
    this.employees,
    this.website,
    this.address,
    this.netZeroProgress,
    this.carbonIntensityScope3,
    this.carbonIntensityScope1And2,
    this.carbonIntensityScope1And2And3,
    this.tempAlignmentScopes1And2,
    this.dnshAssessmentPass,
    this.goodGovernanceAssessment,
    this.contributeToEnvironmentOrSocialObjective,
    this.sustainableInvestment,
    this.scope1Emissions,
    this.scope2Emissions,
    this.scope3Emissions,
    this.totalEmissions,
    this.listingDate,
    this.marketCap,
    this.ibkrConnectionId,
    this.image,
    this.createdBy,
    this.updatedBy,
  });

  factory StockSearchModel.fromJson(Map<String, dynamic> json) {
    return StockSearchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      alpacaId: json['alpaca_id'] as String,
      exchange: json['exchange'] as String,
      description: json['description'] as String?,
      assetType: json['asset_type'] as String,
      isin: json['isin'] as String?,
      industry: json['industry'] as String?,
      sector: json['sector'] as String?,
      employees: json['employees'] as int?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      netZeroProgress: json['net_zero_progress']?.toDouble(),
      carbonIntensityScope3: json['carbon_intensity_scope_3']?.toDouble(),
      carbonIntensityScope1And2: json['carbon_intensity_scope_1_and_2']?.toDouble(),
      carbonIntensityScope1And2And3: json['carbon_intensity_scope_1_and_2_and_3']?.toDouble(),
      tempAlignmentScopes1And2: json['temp_alignment_scopes_1_and_2'] as String?,
      dnshAssessmentPass: json['dnsh_assessment_pass'] as bool?,
      goodGovernanceAssessment: json['good_governance_assessment'] as bool?,
      contributeToEnvironmentOrSocialObjective: json['contribute_to_environment_or_social_objective'] as bool?,
      sustainableInvestment: json['sustainable_investment'] as bool?,
      scope1Emissions: json['scope_1_emissions']?.toDouble(),
      scope2Emissions: json['scope_2_emissions']?.toDouble(),
      scope3Emissions: json['scope_3_emissions']?.toDouble(),
      totalEmissions: json['total_emissions']?.toDouble(),
      listingDate: json['listing_date'] as String?,
      marketCap: json['market_cap'] as String?,
      ibkrConnectionId: json['ibkr_connection_id'] as int?,
      image: json['image'] != null ? StockImage.fromJson(json['image']) : null,
      createdBy: json['createdBy'] != null ? User.fromJson(json['createdBy']) : null,
      updatedBy: json['updatedBy'] != null ? User.fromJson(json['updatedBy']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'alpaca_id': alpacaId,
      'exchange': exchange,
      'description': description,
      'asset_type': assetType,
      'isin': isin,
      'industry': industry,
      'sector': sector,
      'employees': employees,
      'website': website,
      'address': address,
      'net_zero_progress': netZeroProgress,
      'carbon_intensity_scope_3': carbonIntensityScope3,
      'carbon_intensity_scope_1_and_2': carbonIntensityScope1And2,
      'carbon_intensity_scope_1_and_2_and_3': carbonIntensityScope1And2And3,
      'temp_alignment_scopes_1_and_2': tempAlignmentScopes1And2,
      'dnsh_assessment_pass': dnshAssessmentPass,
      'good_governance_assessment': goodGovernanceAssessment,
      'contribute_to_environment_or_social_objective': contributeToEnvironmentOrSocialObjective,
      'sustainable_investment': sustainableInvestment,
      'scope_1_emissions': scope1Emissions,
      'scope_2_emissions': scope2Emissions,
      'scope_3_emissions': scope3Emissions,
      'total_emissions': totalEmissions,
      'listing_date': listingDate,
      'market_cap': marketCap,
      'ibkr_connection_id': ibkrConnectionId,
      'image': image?.toJson(),
      'createdBy': createdBy?.toJson(),
      'updatedBy': updatedBy?.toJson(),
    };
  }
}

class StockImage {
  final int id;
  final String name;
  final String? alternativeText;
  final String? caption;
  final int width;
  final int height;
  final dynamic formats;
  final String hash;
  final String ext;
  final String mime;
  final double size;
  final String url;
  final String? previewUrl;
  final String provider;
  final dynamic providerMetadata;
  final String folderPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  StockImage({
    required this.id,
    required this.name,
    this.alternativeText,
    this.caption,
    required this.width,
    required this.height,
    this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    this.previewUrl,
    required this.provider,
    this.providerMetadata,
    required this.folderPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StockImage.fromJson(Map<String, dynamic> json) {
    return StockImage(
      id: json['id'] as int,
      name: json['name'] as String,
      alternativeText: json['alternativeText'] as String?,
      caption: json['caption'] as String?,
      width: json['width'] as int,
      height: json['height'] as int,
      formats: json['formats'],
      hash: json['hash'] as String,
      ext: json['ext'] as String,
      mime: json['mime'] as String,
      size: json['size'] is int ? (json['size'] as int).toDouble() : json['size'] as double,
      url: json['url'] as String,
      previewUrl: json['previewUrl'] as String?,
      provider: json['provider'] as String,
      providerMetadata: json['provider_metadata'],
      folderPath: json['folderPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alternativeText': alternativeText,
      'caption': caption,
      'width': width,
      'height': height,
      'formats': formats,
      'hash': hash,
      'ext': ext,
      'mime': mime,
      'size': size,
      'url': url,
      'previewUrl': previewUrl,
      'provider': provider,
      'provider_metadata': providerMetadata,
      'folderPath': folderPath,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final String? username;
  final String email;
  final String password;
  final String? resetPasswordToken;
  final String? registrationToken;
  final bool isActive;
  final bool blocked;
  final String? preferedLanguage;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.username,
    required this.email,
    required this.password,
    this.resetPasswordToken,
    this.registrationToken,
    required this.isActive,
    required this.blocked,
    this.preferedLanguage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      username: json['username'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      resetPasswordToken: json['resetPasswordToken'] as String?,
      registrationToken: json['registrationToken'] as String?,
      isActive: json['isActive'] as bool,
      blocked: json['blocked'] as bool,
      preferedLanguage: json['preferedLanguage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'password': password,
      'resetPasswordToken': resetPasswordToken,
      'registrationToken': registrationToken,
      'isActive': isActive,
      'blocked': blocked,
      'preferedLanguage': preferedLanguage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}