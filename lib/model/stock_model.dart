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
  final String? name; // Nullable
  final String? symbol; // Nullable

  Stock({
    required this.id,
    this.name,
    this.symbol,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'] as int? ?? 0, // Default to 0 if null
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );
  }
}