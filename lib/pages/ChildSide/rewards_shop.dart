import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/models/reward_item.dart';
import 'package:abilify/services/rewards_provider.dart';
import 'package:abilify/services/cart_provider.dart';
import 'package:abilify/pages/ChildSide/rewards_cart.dart';

class RewardsShop extends StatefulWidget {
  const RewardsShop({Key? key}) : super(key: key);

  @override
  _RewardsShopState createState() => _RewardsShopState();
}

class _RewardsShopState extends State<RewardsShop> {
  final RewardsProvider _rewardsProvider = RewardsProvider();
  final CartProvider _cartProvider = CartProvider();
  String _selectedCategory = 'All';
  List<RewardItem> _displayedItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRewards();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh when returning to this page
    _loadRewards();
  }

  Future<void> _loadRewards() async {
    await _rewardsProvider.init();
    _updateDisplayedItems();
    setState(() {
      _isLoading = false;
    });
  }

  void _updateDisplayedItems() {
    if (_selectedCategory == 'All') {
      _displayedItems = RewardItem.getRewardItems();
    } else {
      _displayedItems = RewardItem.getItemsByCategory(_selectedCategory);
    }
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _updateDisplayedItems();
    });
  }

  void _addToCart(RewardItem item) {
    _cartProvider.addToCart(item);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RewardsCart()),
            ).then((_) => setState(() {}));
          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      appBar: AppBar(
        title: Text(
          'Rewards Shop',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber.shade300,
        elevation: 0,
        actions: [
          // Debug menu
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'reset') {
                await _rewardsProvider.resetPurchasedItems();
                // Also reset points to 100
                await _rewardsProvider.init();
                _loadRewards();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.refresh, color: Colors.black54),
                    SizedBox(width: 8),
                    Text('Reset Purchases & Points'),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RewardsCart()),
                  ).then((_) => setState(() {}));
                },
              ),
              if (_cartProvider.cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartProvider.cartItems.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Points display
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            Icon(Icons.stars, color: Colors.amber, size: 20),
                            SizedBox(width: 6),
                            Text(
                              '${_rewardsProvider.points}',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Category selector
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: RewardItem.getCategories().map((category) {
                      bool isSelected = category == _selectedCategory;
                      return GestureDetector(
                        onTap: () => _selectCategory(category),
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.amber : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: GoogleFonts.poppins(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                
                // Rewards grid
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _displayedItems.length,
                    itemBuilder: (context, index) {
                      final item = _displayedItems[index];
                      final isPurchased = _rewardsProvider.isItemPurchased(item.id);
                      final isInCart = _cartProvider.isInCart(item.id);
                      
                      return RewardCard(
                        key: ValueKey("${item.id}_${isPurchased}_${isInCart}"),
                        item: item,
                        isPurchased: isPurchased,
                        isInCart: isInCart,
                        onAddToCart: () => _addToCart(item),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final RewardItem item;
  final bool isPurchased;
  final bool isInCart;
  final VoidCallback onAddToCart;

  const RewardCard({
    Key? key,
    required this.item,
    required this.isPurchased,
    required this.isInCart,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: getColorForCategory(item.category).withOpacity(0.2),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
                if (isPurchased)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'PURCHASED',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.description,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.stars, color: Colors.amber, size: 14),
                          SizedBox(width: 2),
                          Text(
                            '${item.points}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      isPurchased
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : isInCart 
                              ? Container(
                                  height: 32,
                                  child: ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                      minimumSize: Size(0, 28),
                                    ),
                                    child: Text(
                                      'In Cart',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 32,
                                  child: ElevatedButton(
                                    onPressed: onAddToCart,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: getColorForCategory(item.category),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                      minimumSize: Size(0, 28),
                                    ),
                                    child: Text(
                                      'Add',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
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