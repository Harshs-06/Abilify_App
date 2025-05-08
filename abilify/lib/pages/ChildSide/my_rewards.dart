import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/models/reward_item.dart';
import 'package:abilify/services/rewards_provider.dart';

class MyRewards extends StatefulWidget {
  const MyRewards({Key? key}) : super(key: key);

  @override
  _MyRewardsState createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  final RewardsProvider _rewardsProvider = RewardsProvider();
  List<RewardItem> _purchasedItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPurchasedRewards();
  }

  Future<void> _loadPurchasedRewards() async {
    await _rewardsProvider.init();
    _updatePurchasedItems();
    setState(() {
      _isLoading = false;
    });
  }

  void _updatePurchasedItems() {
    List<RewardItem> allItems = RewardItem.getRewardItems();
    _purchasedItems = allItems.where(
      (item) => _rewardsProvider.isItemPurchased(item.id)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      appBar: AppBar(
        title: Text(
          'My Rewards',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber.shade300,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Points display
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.amber.shade300,
                        Color.fromARGB(255, 251, 239, 215),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Points',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.stars, color: Colors.amber),
                            SizedBox(width: 8),
                            Text(
                              '${_rewardsProvider.points}',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.amber),
                      SizedBox(width: 8),
                      Text(
                        'Your Reward Collection',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Purchased items list
                Expanded(
                  child: _purchasedItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.card_giftcard, 
                                size: 80, 
                                color: Colors.amber.withOpacity(0.7)
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No rewards yet!',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Complete tasks to earn points\nand buy rewards in the shop',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: _purchasedItems.length,
                          itemBuilder: (context, index) {
                            final item = _purchasedItems[index];
                            return PurchasedRewardCard(item: item);
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class PurchasedRewardCard extends StatelessWidget {
  final RewardItem item;

  const PurchasedRewardCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image container
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: getColorForCategory(item.category).withOpacity(0.2),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
            ),
            child: Center(
              child: Image.asset(
                item.imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getColorForCategory(item.category),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.category,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.stars, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${item.points} points',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColorForCategory(String category) {
    switch (category) {
      case 'Toys':
        return Colors.blue;
      case 'Digital':
        return Colors.purple;
      case 'Activities':
        return Colors.orange;
      default:
        return Colors.amber;
    }
  }
} 