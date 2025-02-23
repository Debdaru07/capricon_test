import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/stock_model.dart';
import '../providers/stock_details_provider.dart';

class StockDetailsScreen extends ConsumerStatefulWidget {
  final int stockId;
  const StockDetailsScreen({super.key, required this.stockId});

  @override
  ConsumerState<StockDetailsScreen> createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends ConsumerState<StockDetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(stockDetailsProvider(widget.stockId).notifier).fetchStockDetails(widget.stockId);
  }

  @override
  Widget build(BuildContext context) {
    final stockState = ref.watch(stockDetailsProvider(widget.stockId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
        elevation: 2,
        backgroundColor: Colors.teal,
      ),
      body: stockState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : stockState.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${stockState.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(stockDetailsProvider(widget.stockId).notifier)
                            .fetchStockDetails(widget.stockId),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : stockState.stockDetails != null
                  ? _buildStockDetails(context, stockState.stockDetails!)
                  : const Center(child: Text('No data available')),
    );
  }

  Widget _buildStockDetails(BuildContext context, StockDetailsModel stock) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.name ?? 'Unknown Stock',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Symbol: ${stock.symbol ?? 'N/A'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Price: ${stock.price != null ? '\$${stock.price!.toStringAsFixed(2)}' : 'N/A'}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: stock.changePercent != null && stock.changePercent! >= 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Change: ${stock.changePercent != null ? '${stock.changePercent!.toStringAsFixed(2)}%' : 'N/A'}',
                    style: TextStyle(
                      color: stock.changePercent != null && stock.changePercent! >= 0
                          ? Colors.green
                          : Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            stock.description ?? 'No description available',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Metrics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildMetricRow('Exchange', stock.exchange ?? 'N/A'),
                  _buildMetricRow('Sector', stock.sector ?? 'N/A'),
                  _buildMetricRow('Industry', stock.industry ?? 'N/A'),
                  _buildMetricRow('Listing Date', stock.listingDate ?? 'N/A'),
                  _buildMetricRow('Market Cap', stock.marketCap ?? 'N/A'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Top Holdings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (stock.holdings.isEmpty)
            const Text('No holdings available')
          else
            ...stock.holdings.take(3).map((holding) => ListTile(
                  title: Text(holding.stock.name ?? 'Unknown'),
                  subtitle: Text(
                      'Percentage: ${holding.percentage != null ? holding.percentage!.toStringAsFixed(2) : 'N/A'}%'),
                  trailing: Text(holding.stock.symbol ?? 'N/A'),
                )),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}