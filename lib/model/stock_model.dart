class StockDetailsModel {
  final int id;
  final String? name; // Nullable since it might not be present
  final String? symbol; // Nullable
  final String? description; // Already nullable, but we'll ensure proper handling
  final String? exchange; // Nullable
  final String? sector; // Nullable
  final String? industry; // Nullable
  final String? listingDate; // Nullable
  final double? price; // Nullable in case price is missing
  final double? changePercent; // Nullable
  final String? marketCap; // Already nullable
  final List<Holding> holdings; // Keep non-nullable, but ensure empty list on null

  StockDetailsModel({
    required this.id,
    this.name,
    this.symbol,
    this.description,
    this.exchange,
    this.sector,
    this.industry,
    this.listingDate,
    this.price,
    this.changePercent,
    this.marketCap,
    required this.holdings,
  });

  factory StockDetailsModel.fromJson(Map<String, dynamic> json) {
    return StockDetailsModel(
      id: json['id'] as int? ?? 0, // Default to 0 if null
      name: json['name'] as String?, // Keep null if absent
      symbol: json['symbol'] as String?,
      description: json['description'] as String?,
      exchange: json['exchange'] as String?,
      sector: json['sector'] as String?,
      industry: json['industry'] as String?,
      listingDate: json['listing_date'] as String?,
      price: json['price'] != null ? (json['price'] as num).toDouble() : null, // Handle null gracefully
      changePercent: json['change_percent'] != null
          ? (json['change_percent'] as num).toDouble()
          : null,
      marketCap: json['market_cap'] as String?,
      holdings: json['holdings'] != null && (json['holdings'] as List).isNotEmpty
          ? (json['holdings'] as List)
              .map((h) => Holding.fromJson(h as Map<String, dynamic>))
              .toList()
          : [], // Empty list if null or empty
    );
  }
}

class Holding {
  final int id;
  final double? percentage; // Nullable in case percentage is missing
  final Stock stock;

  Holding({
    required this.id,
    this.percentage,
    required this.stock,
  });

  factory Holding.fromJson(Map<String, dynamic> json) {
    return Holding(
      id: json['id'] as int? ?? 0, // Default to 0 if null
      percentage: json['percentage'] != null ? (json['percentage'] as num).toDouble() : null,
      stock: Stock.fromJson(json['stock'] as Map<String, dynamic>? ?? {}), // Empty map if null
    );
  }
}

class Stock {
  final int id;
  final String name;
  final String symbol;
  final String createdAt;
  final String updatedAt;
  final String alpacaId;
  final String exchange;
  final String description;
  final String assetType;
  final String isin;
  final String industry;
  final String sector;
  final int employees;
  final String website;
  final String address;
  final String? netZeroProgress;
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
  final String listingDate;
  final String marketCap;
  final int? ibkrConnectionId;

  Stock({
    required this.id,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.alpacaId,
    required this.exchange,
    required this.description,
    required this.assetType,
    required this.isin,
    required this.industry,
    required this.sector,
    required this.employees,
    required this.website,
    required this.address,
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
    required this.listingDate,
    required this.marketCap,
    this.ibkrConnectionId,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      alpacaId: json['alpaca_id'] as String? ?? '',
      exchange: json['exchange'] as String? ?? '',
      description: json['description'] as String? ?? '',
      assetType: json['asset_type'] as String? ?? '',
      isin: json['isin'] as String? ?? '',
      industry: json['industry'] as String? ?? '',
      sector: json['sector'] as String? ?? '',
      employees: json['employees'] as int? ?? 0,
      website: json['website'] as String? ?? '',
      address: json['address'] as String? ?? '',
      netZeroProgress: json['net_zero_progress'] as String?,
      carbonIntensityScope3: json['carbon_intensity_scope_3'] != null ? (json['carbon_intensity_scope_3'] as num).toDouble() : null,
      carbonIntensityScope1And2: json['carbon_intensity_scope_1_and_2'] != null ? (json['carbon_intensity_scope_1_and_2'] as num).toDouble() : null,
      carbonIntensityScope1And2And3: json['carbon_intensity_scope_1_and_2_and_3'] != null ? (json['carbon_intensity_scope_1_and_2_and_3'] as num).toDouble() : null,
      tempAlignmentScopes1And2: json['temp_alignment_scopes_1_and_2'] as String?,
      dnshAssessmentPass: json['dnsh_assessment_pass'] as bool?,
      goodGovernanceAssessment: json['good_governance_assessment'] as bool?,
      contributeToEnvironmentOrSocialObjective: json['contribute_to_environment_or_social_objective'] as bool?,
      sustainableInvestment: json['sustainable_investment'] as bool?,
      scope1Emissions: json['scope_1_emissions'] != null ? (json['scope_1_emissions'] as num).toDouble() : null,
      scope2Emissions: json['scope_2_emissions'] != null ? (json['scope_2_emissions'] as num).toDouble() : null,
      scope3Emissions: json['scope_3_emissions'] != null ? (json['scope_3_emissions'] as num).toDouble() : null,
      totalEmissions: json['total_emissions'] != null ? (json['total_emissions'] as num).toDouble() : null,
      listingDate: json['listing_date'] as String? ?? '',
      marketCap: json['market_cap'] as String? ?? '',
      ibkrConnectionId: json['ibkr_connection_id'] as int?,
    );
  }
}
