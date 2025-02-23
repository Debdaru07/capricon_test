import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../core/constants.dart';
import '../../model/stock_model.dart';

class StockHoldingDetails extends StatefulWidget {
  final Holding holding;
  const StockHoldingDetails({super.key, required this.holding});

  @override
  State<StockHoldingDetails> createState() => _StockHoldingDetailsState();
}

class _StockHoldingDetailsState extends State<StockHoldingDetails> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _launchURL(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final stock = widget.holding.stock;

    return Theme(
      data: AppConstants.darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            stock.name ?? 'N/A',
            style: AppConstants.headlineFont.copyWith(
              fontSize: 20,
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
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppConstants.accentGold),
                ),
                color: Colors.grey[900],
                child: ListTile(
                  contentPadding: const EdgeInsets.all(AppConstants.paddingMedium),
                  title: Text(
                    stock.name ?? 'Unknown',
                    style: AppConstants.bodyFont.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor,
                    ),
                  ),
                  subtitle: Text(
                    stock.symbol ?? 'N/A',
                    style: AppConstants.bodyFont.copyWith(
                      fontSize: 14,
                      color: AppConstants.textColor.withOpacity(0.8),
                    ),
                  ),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Percentage: ${widget.holding.percentage?.toStringAsFixed(2) ?? 'N/A'}%',
                        style: AppConstants.bodyFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.textColor,
                        ),
                      ),
                      Icon(
                        _isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: AppConstants.accentGold,
                      )
                    ],
                  ),
                  onTap: _toggleExpansion,
                  // trailing: Icon(
                  //   _isExpanded ? Icons.expand_less : Icons.expand_more,
                  //   color: AppConstants.accentGold,
                  // ),
                ),
              ),
              if (_isExpanded)
                Padding(
                  padding: const EdgeInsets.only(top: AppConstants.paddingMedium),
                  child: Card(
                    elevation: 2,
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
                          _buildDetailRow('Exchange', stock.exchange ?? ''),
                          _buildDetailRow('Industry', stock.industry ?? ''),
                          _buildDetailRow('Sector', stock.sector ?? ''),
                          _buildDetailRow('Employees', (stock.employees ?? 0).toString()),
                          _buildDetailRow('Listing Date', stock.listingDate ?? ''),
                          _buildDetailRow('Market Cap', stock.marketCap ?? ''),
                          _buildLinkRow('Website', stock.website ?? ''),
                          Padding(
                            padding: const EdgeInsets.only(top: AppConstants.paddingSmall),
                            child: Text(
                              'Description:',
                              style: AppConstants.bodyFont.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppConstants.paddingSmall),
                            child: Text(
                              stock.description!,
                              style: AppConstants.bodyFont.copyWith(
                                fontSize: 14,
                                color: AppConstants.textColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppConstants.paddingSmall),
                          Text(
                            'Environmental Data:',
                            style: AppConstants.bodyFont.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.textColor,
                            ),
                          ),
                          _buildDetailRow(
                              'Net Zero Progress', stock.netZeroProgress ?? 'N/A'),
                          _buildDetailRow('Carbon Intensity (Scopes 1+2+3)',
                              stock.carbonIntensityScope1And2And3?.toString() ?? 'N/A'),
                          _buildDetailRow('Scope 1 Emissions',
                              stock.scope1Emissions?.toString() ?? 'N/A'),
                          _buildDetailRow('Scope 2 Emissions',
                              stock.scope2Emissions?.toString() ?? 'N/A'),
                          _buildDetailRow('Scope 3 Emissions',
                              stock.scope3Emissions?.toString() ?? 'N/A'),
                          _buildDetailRow('Total Emissions',
                              stock.totalEmissions?.toString() ?? 'N/A'),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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

  Widget _buildLinkRow(String label, String url) {
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
          GestureDetector(
            onTap: () => _launchURL(url),
            child: Text(
              url,
              style: AppConstants.bodyFont.copyWith(
                fontSize: 16,
                color: AppConstants.accentGold,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}