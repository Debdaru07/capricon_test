import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/api_client.dart';
import '../model/stock_model.dart';
import 'login_provider.dart';

class StockDetailsState {
  final bool isLoading;
  final StockDetailsModel? stockDetails;
  final String? error;

  StockDetailsState({
    this.isLoading = false,
    this.stockDetails,
    this.error,
  });

  StockDetailsState copyWith({
    bool? isLoading,
    StockDetailsModel? stockDetails,
    String? error,
  }) {
    return StockDetailsState(
      isLoading: isLoading ?? this.isLoading,
      stockDetails: stockDetails ?? this.stockDetails,
      error: error ?? this.error,
    );
  }
}

class StockDetailsNotifier extends StateNotifier<StockDetailsState> {
  final ApiClient _apiClient;
  Timer? _debounceTimer;
  bool _disposed = false;

  StockDetailsNotifier(this._apiClient) : super(StockDetailsState());

  Future<void> fetchStockDetails(int stockId) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (_disposed) return;
      state = state.copyWith(isLoading: true, error: null);
      try {
        final response = await _apiClient.dio.get('/api/stocks/$stockId');
        final stockDetails = StockDetailsModel.fromJson(response.data);
        if (!_disposed) {
          state = state.copyWith(isLoading: false, stockDetails: stockDetails);
        }
      } on DioException catch (e) {
        String errorMessage = e.response?.data['error']?.toString() ??
            e.message ??
            'Failed to fetch stock details';
        log('Error fetching stock details: $errorMessage');
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

// Use .family to parameterize the provider with stockId
final stockDetailsProvider = StateNotifierProvider.family<StockDetailsNotifier, StockDetailsState, int>(
  (ref, stockId) {
    final loginState = ref.watch(loginProvider);
    final token = loginState.authResponse?.jwt;
    log('JWT token for stock details (ID: $stockId): $token');
    final apiClient = ApiClient(token: token);
    return StockDetailsNotifier(apiClient);
  },
);