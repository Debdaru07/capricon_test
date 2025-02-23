import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants.dart';
import '../model/stock_model.dart';
import '../providers/stock_details_provider.dart';
import 'stock_holdings/stock_holdings_details.dart';
import 'stock_holdings/stock_holdings_listing.dart';

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

    return Theme(
      data: AppConstants.darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Stock Details',
            style: AppConstants.linkFont.copyWith(
              fontSize: 25,
              color: AppConstants.primaryBackground,
            ),
          ),
          elevation: 2,
          backgroundColor: AppConstants.accentGold,
          iconTheme: IconThemeData(
            color: Colors.black, // Set the back button color to black
          )
        ),
        body: stockState.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppConstants.accentGold))
            : stockState.error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${stockState.error}',
                          style: AppConstants.bodyFont.copyWith(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConstants.paddingMedium),
                        ElevatedButton(
                          onPressed: () => ref
                              .read(stockDetailsProvider(widget.stockId).notifier)
                              .fetchStockDetails(widget.stockId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.accentGold,
                            foregroundColor: AppConstants.primaryBackground,
                          ),
                          child: Text(
                            'Retry',
                            style: AppConstants.bodyFont,
                          ),
                        ),
                      ],
                    ),
                  )
                : stockState.stockDetails != null
                    ? _buildStockDetails(context, stockState.stockDetails!)
                    : Center(
                        child: Text(
                          'No data available',
                          style: AppConstants.bodyFont,
                        ),
                      ),
      ),
    );
  }

  Widget _buildStockDetails(BuildContext context, StockDetailsModel stock) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppConstants.accentGold),
            ),
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.name ?? 'Unknown Stock',
                    style: AppConstants.headlineFont.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Symbol: ${stock.symbol ?? 'N/A'}',
                        style: AppConstants.bodyFont.copyWith(
                          fontSize: 16,
                          color: AppConstants.textColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            stock.price != null ? '\$${stock.price!.toStringAsFixed(2)}' : 'N/A',
                            style: AppConstants.bodyFont.copyWith(
                              fontSize: 16,
                              color: AppConstants.textColor,
                            ),
                          ),
                          const SizedBox(width: AppConstants.paddingSmall),
                          if (stock.changePercent != null)
                            Row(
                              children: [
                                Icon(
                                  stock.changePercent! >= 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                  color: stock.changePercent! >= 0 ? Colors.green : Colors.red,
                                  size: 24,
                                ),
                                Text(
                                  '${stock.changePercent!.toStringAsFixed(2)}%',
                                  style: AppConstants.bodyFont.copyWith(
                                    fontSize: 16,
                                    color: stock.changePercent! >= 0 ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          const Divider(color: AppConstants.accentGold, thickness: 1),
          const SizedBox(height: AppConstants.paddingMedium),
          Text(
            'Description',
            style: AppConstants.headlineFont.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppConstants.textColor,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            stock.description ?? 'No description available',
            style: AppConstants.bodyFont.copyWith(
              fontSize: 14,
              color: AppConstants.textColor.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          const Divider(color: AppConstants.accentGold, thickness: 1),
          const SizedBox(height: AppConstants.paddingSmall),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppConstants.accentGold),
            ),
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Metrics',
                    style: AppConstants.headlineFont.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor,
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingMedium),
                  _buildMetricRow('Exchange', stock.exchange ?? 'N/A'),
                  _buildMetricRow('Sector', stock.sector ?? 'N/A'),
                  _buildMetricRow('Industry', stock.industry ?? 'N/A'),
                  _buildMetricRow('Listing Date', stock.listingDate ?? 'N/A'),
                  _buildMetricRow('Market Cap', stock.marketCap ?? 'N/A'),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingMedium),
          const Divider(color: AppConstants.accentGold, thickness: 1),
          const SizedBox(height: AppConstants.paddingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Holdings',
                style: AppConstants.headlineFont.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              // StockHoldingsListing
              InkWell(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (BuildContext context) => StockHoldingsListing(initialHoldings: stock.holdings,)
                    )
                  );
                },
                child: Text(
                  'See All',
                  style: AppConstants.linkFont.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                    decoration: TextDecoration.underline, // Add underline
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          if (stock.holdings.isEmpty)
            Text(
              'No holdings available',
              style: AppConstants.bodyFont.copyWith(
                fontSize: 14,
                color: AppConstants.textColor.withOpacity(0.8),
              ),
            )
          else
            ...stock.holdings.take(3).map((holding) => Card(
              margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppConstants.accentGold),
              ),
              color: Colors.grey[900],
              child: ListTile(
                contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
                leading: const Icon(Icons.business, color: AppConstants.accentGold),
                title: Text(
                  holding.stock.name ?? 'Unknown',
                  style: AppConstants.bodyFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                ),
                subtitle: Text(
                  holding.stock.symbol ?? 'N/A',
                  style: AppConstants.bodyFont.copyWith(
                    fontSize: 14,
                    color: AppConstants.textColor.withOpacity(0.8),
                  ),
                ),
                trailing: Text(
                  'Percentage: ${holding.percentage != null ? '${holding.percentage!.toStringAsFixed(2)}%' : 'N/A'}',
                  style: AppConstants.bodyFont.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockHoldingDetails(holding: holding),
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppConstants.bodyFont.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppConstants.textColor,
            ),
          ),
          Text(
            value,
            style: AppConstants.bodyFont.copyWith(
              fontSize: 16,
              color: AppConstants.textColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}