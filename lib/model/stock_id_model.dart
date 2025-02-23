class StockSearchModel {
  final int id;
  final String name;
  final String symbol;
  final DateTime createdAt;
  final DateTime updatedAt;
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
  final String netZeroProgress;
  final double carbonIntensityScope3;
  final double carbonIntensityScope1And2;
  final double carbonIntensityScope1And2And3;
  final String tempAlignmentScopes1And2;
  final bool dnshAssessmentPass;
  final bool goodGovernanceAssessment;
  final bool contributeToEnvironmentOrSocialObjective;
  final bool sustainableInvestment;
  final double scope1Emissions;
  final double scope2Emissions;
  final double scope3Emissions;
  final double totalEmissions;
  final String listingDate;
  final String marketCap;
  final int ibkrConnectionId;
  final double price;
  final double changePercent;
  final List<dynamic> holdings;
  final List<dynamic> sectorAllocation;
  final double sustainableInvestmentHoldingPercentage;
  final bool inPortfolio;

  StockSearchModel({
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
    required this.netZeroProgress,
    required this.carbonIntensityScope3,
    required this.carbonIntensityScope1And2,
    required this.carbonIntensityScope1And2And3,
    required this.tempAlignmentScopes1And2,
    required this.dnshAssessmentPass,
    required this.goodGovernanceAssessment,
    required this.contributeToEnvironmentOrSocialObjective,
    required this.sustainableInvestment,
    required this.scope1Emissions,
    required this.scope2Emissions,
    required this.scope3Emissions,
    required this.totalEmissions,
    required this.listingDate,
    required this.marketCap,
    required this.ibkrConnectionId,
    required this.price,
    required this.changePercent,
    required this.holdings,
    required this.sectorAllocation,
    required this.sustainableInvestmentHoldingPercentage,
    required this.inPortfolio,
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
      description: json['description'] as String,
      assetType: json['asset_type'] as String,
      isin: json['isin'] as String,
      industry: json['industry'] as String,
      sector: json['sector'] as String,
      employees: json['employees'] as int,
      website: json['website'] as String,
      address: json['address'] as String,
      netZeroProgress: json['net_zero_progress'] as String,
      carbonIntensityScope3: (json['carbon_intensity_scope_3'] as num).toDouble(),
      carbonIntensityScope1And2: (json['carbon_intensity_scope_1_and_2'] as num).toDouble(),
      carbonIntensityScope1And2And3: (json['carbon_intensity_scope_1_and_2_and_3'] as num).toDouble(),
      tempAlignmentScopes1And2: json['temp_alignment_scopes_1_and_2'] as String,
      dnshAssessmentPass: json['dnsh_assessment_pass'] as bool,
      goodGovernanceAssessment: json['good_governance_assessment'] as bool,
      contributeToEnvironmentOrSocialObjective: json['contribute_to_environment_or_social_objective'] as bool,
      sustainableInvestment: json['sustainable_investment'] as bool,
      scope1Emissions: (json['scope_1_emissions'] as num).toDouble(),
      scope2Emissions: (json['scope_2_emissions'] as num).toDouble(),
      scope3Emissions: (json['scope_3_emissions'] as num).toDouble(),
      totalEmissions: (json['total_emissions'] as num).toDouble(),
      listingDate: json['listing_date'] as String,
      marketCap: json['market_cap'] as String,
      ibkrConnectionId: json['ibkr_connection_id'] as int,
      price: (json['price'] as num).toDouble(),
      changePercent: (json['change_percent'] as num).toDouble(),
      holdings: json['holdings'] as List<dynamic>,
      sectorAllocation: json['sector_allocation'] as List<dynamic>,
      sustainableInvestmentHoldingPercentage: (json['sustainable_investment_holding_percentage'] as num).toDouble(),
      inPortfolio: json['in_portfolio'] as bool,
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
      'price': price,
      'change_percent': changePercent,
      'holdings': holdings,
      'sector_allocation': sectorAllocation,
      'sustainable_investment_holding_percentage': sustainableInvestmentHoldingPercentage,
      'in_portfolio': inPortfolio,
    };
  }
}