import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/stock_model.dart';

class StockHoldingsState {
  final List<Holding> holdings;
  final List<Holding> filteredHoldings;
  final bool isLoading;
  final String? error;

  StockHoldingsState({
    required this.holdings,
    required this.filteredHoldings,
    this.isLoading = false,
    this.error,
  });

  StockHoldingsState copyWith({
    List<Holding>? holdings,
    List<Holding>? filteredHoldings,
    bool? isLoading,
    String? error,
  }) {
    return StockHoldingsState(
      holdings: holdings ?? this.holdings,
      filteredHoldings: filteredHoldings ?? this.filteredHoldings,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class StockHoldingsNotifier extends StateNotifier<StockHoldingsState> {
  StockHoldingsNotifier() : super(StockHoldingsState(holdings: [], filteredHoldings: []));

  void setHoldings(List<Holding> holdings) {
    state = state.copyWith(
      holdings: holdings,
      filteredHoldings: holdings,
      isLoading: false,
    );
  }

  void searchHoldings(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredHoldings: state.holdings);
      return;
    }

    final filtered = state.holdings.where((holding) {
      final name = holding.stock.name?.toLowerCase();
      final symbol = holding.stock.symbol?.toLowerCase();
      final searchQuery = query.toLowerCase();
      return (name ?? '').contains(searchQuery) || (symbol ?? '').contains(searchQuery);
    }).toList();

    state = state.copyWith(filteredHoldings: filtered);
  }
}

final stockHoldingsProvider = StateNotifierProvider<StockHoldingsNotifier, StockHoldingsState>((ref) {
  return StockHoldingsNotifier();
});