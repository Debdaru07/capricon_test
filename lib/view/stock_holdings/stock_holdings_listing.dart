import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart'; // Add this import for SchedulerBinding
import '../../core/constants.dart';
import '../../model/stock_model.dart';
import '../../providers/stock_holdings_provider.dart';
import 'stock_holdings_details.dart';
 


class StockHoldingsListing extends ConsumerStatefulWidget {
  final List<Holding> initialHoldings;
  const StockHoldingsListing({super.key, required this.initialHoldings});

  @override
  ConsumerState<StockHoldingsListing> createState() => _StockHoldingsListingState();
}

class _StockHoldingsListingState extends ConsumerState<StockHoldingsListing> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(stockHoldingsProvider.notifier).setHoldings(widget.initialHoldings);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final holdingsState = ref.watch(stockHoldingsProvider);

    return Theme(
      data: AppConstants.darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Top Holdings',
            style: AppConstants.headlineFont.copyWith(
              fontSize: 24,
              color: AppConstants.primaryBackground,
            ),
          ),
          backgroundColor: AppConstants.accentGold,
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search holdings...',
                  hintStyle: AppConstants.bodyFont.copyWith(
                    color: AppConstants.textColor.withOpacity(0.7),
                  ),
                  prefixIcon: const Icon(Icons.search, color: AppConstants.accentGold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppConstants.accentGold),
                  ),
                ),
                onChanged: (value) {
                  ref.read(stockHoldingsProvider.notifier).searchHoldings(value);
                },
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Expanded(
                child: holdingsState.isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppConstants.accentGold))
                  : holdingsState.error != null
                    ? Center(
                        child: Text(
                          'Error: ${holdingsState.error}',
                          style: AppConstants.bodyFont.copyWith(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: holdingsState.filteredHoldings.length,
                        itemBuilder: (context, index) {
                          final holding = holdingsState.filteredHoldings[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: AppConstants.paddingSmall,
                            ),
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
                                holding.stock.name,
                                style: AppConstants.bodyFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.textColor,
                                ),
                              ),
                              subtitle: Text(
                                holding.stock.symbol,
                                style: AppConstants.bodyFont.copyWith(
                                  fontSize: 14,
                                  color: AppConstants.textColor.withOpacity(0.8),
                                ),
                              ),
                              trailing: Text(
                                'Percentage: ${holding.percentage?.toStringAsFixed(2) ?? 'N/A'}%',
                                style: AppConstants.bodyFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.textColor,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StockHoldingDetails(holding: holding),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
