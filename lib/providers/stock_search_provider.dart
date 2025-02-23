import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/stock_search_model.dart';
import '../core/api_client.dart';
import 'login_provider.dart';

class StockSearchState {
  final bool isLoading;
  final List<StockSearchModel> stocks;
  final String? error;

  StockSearchState({
    this.isLoading = false,
    this.stocks = const [],
    this.error,
  });

  StockSearchState copyWith({bool? isLoading, List<StockSearchModel>? stocks, String? error}) {
    return StockSearchState(
      isLoading: isLoading ?? this.isLoading,
      stocks: stocks ?? this.stocks,
      error: error ?? this.error,
    );
  }
}

class StockSearchNotifier extends StateNotifier<StockSearchState> {
  final ApiClient _apiClient;
  Timer? _debounceTimer;
  bool _disposed = false;

  StockSearchNotifier(this._apiClient) : super(StockSearchState()) {
    searchStocks('T');
  }

  Future<void> searchStocks(String query) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (_disposed) return;
      state = state.copyWith(isLoading: true, error: null);
      try {
        final response = await _apiClient.dio.get('/api/stocks/search?query=$query');
        final List<dynamic> data = response.data;
        final stocks = data.map((json) => StockSearchModel.fromJson(json)).toList();
        state = state.copyWith(isLoading: false, stocks: stocks);
      } on DioException catch (e) {
        String errorMessage;
        if (e.response?.data != null && e.response!.data is Map<String, dynamic>) {
          final errorData = e.response!.data as Map<String, dynamic>;
          errorMessage = errorData['error'] is Map<String, dynamic>
              ? (errorData['error']['message'] as String? ?? 'Unknown error')
              : errorData['error']?.toString() ?? e.message ?? '';
        } else {
          errorMessage = e.message ?? '';
        }
        log('Error: $errorMessage');
        if (!_disposed) {
          state = state.copyWith(isLoading: false, error: errorMessage);
        }
      } catch (e) {
        if (!_disposed) {
          state = state.copyWith(isLoading: false, error: e.toString());
        }
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _disposed = true;
    super.dispose();
  }
}

final stockSearchProvider = StateNotifierProvider<StockSearchNotifier, StockSearchState>((ref) {
  final loginState = ref.watch(loginProvider);
  final token = loginState.authResponse?.jwt;
  log('jwt token :- $token');
  return StockSearchNotifier(ApiClient(token: token));
});