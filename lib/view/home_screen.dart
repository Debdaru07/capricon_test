import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../providers/login_provider.dart';
import '../providers/stock_search_provider.dart';
import 'login.dart';
import 'stock_details.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: ''); // Default to 'T'
  }

  @override
  void dispose() {
    _searchController.dispose(); // Clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final stockState = ref.watch(stockSearchProvider);
    final stockNotifier = ref.read(stockSearchProvider.notifier);
    final loginNotifier = ref.read(loginProvider.notifier);

    final screenHeight = MediaQuery.of(context).size.height;

    void handleLogout() {
      ScaffoldMessenger.of(context).showSnackBar(
        AppConstants.successSnackBar('Successfully logged out'),
      );
      loginNotifier.logout();
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }

    return Theme(
      data: AppConstants.darkTheme,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.125,
                decoration: BoxDecoration(
                  color: AppConstants.accentGold,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                    ),
                    const SizedBox(width: AppConstants.paddingMedium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome, ${loginState.authResponse?.user.fullName ?? "User"}!',
                            style: AppConstants.headlineFont.copyWith(
                              fontSize: 20,
                              color: AppConstants.primaryBackground,
                            ),
                          ),
                          const SizedBox(height: AppConstants.paddingSmall),
                          Text(
                            'See some listings below.',
                            style: AppConstants.bodyFont.copyWith(
                              fontSize: 14,
                              color: AppConstants.primaryBackground.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: AppConstants.primaryBackground),
                      onPressed: handleLogout,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingLarge),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search stocks...',
                    hintStyle: AppConstants.bodyFont.copyWith(color: AppConstants.textColor.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.search, color: AppConstants.accentGold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppConstants.accentGold),
                    ),
                  ),
                  onChanged: (value) {
                    stockNotifier.searchStocks(value.isEmpty ? 'T' : value);
                  },
                ),
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Expanded(
                child: stockState.isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppConstants.accentGold))
                    : stockState.error != null
                        ? Center(
                            child: Text(
                              'Error: ${stockState.error}',
                              style: AppConstants.bodyFont,
                            ),
                          )
                        : ListView.builder(
                            itemCount: stockState.stocks.length,
                            itemBuilder: (context, index) {
                              final stock = stockState.stocks[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StockDetailsScreen(stockId: stock.id)));
                                },
                                child: Card(
                                  color: Colors.grey[900],
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.paddingLarge,
                                    vertical: AppConstants.paddingSmall,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(color: AppConstants.accentGold),
                                  ),
                                  child: ListTile(
                                    leading: stock.image != null
                                        ? CircleAvatar(backgroundImage: NetworkImage(stock.image!.url))
                                        : const CircleAvatar(child: Icon(Icons.business, color: AppConstants.accentGold)),
                                    title: Text(
                                      stock.name,
                                      style: AppConstants.bodyFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${stock.symbol} • ${stock.exchange}',
                                      style: AppConstants.bodyFont.copyWith(fontSize: 14),
                                    ),
                                  ),
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