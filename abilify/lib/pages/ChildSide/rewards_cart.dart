import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/models/reward_item.dart';
import 'package:abilify/services/rewards_provider.dart';
import 'package:abilify/services/cart_provider.dart';

class RewardsCart extends StatefulWidget {
  const RewardsCart({Key? key}) : super(key: key);

  @override
  _RewardsCartState createState() => _RewardsCartState();
}

class _RewardsCartState extends State<RewardsCart> {
  final RewardsProvider _rewardsProvider = RewardsProvider();
  final CartProvider _cartProvider = CartProvider();
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    await _rewardsProvider.init();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _purchaseSelectedItems() async {
    final selectedItems = _cartProvider.selectedItems;
    final totalPoints = _cartProvider.totalSelectedPoints;
    
    // Check if user can afford all selected items
    if (_rewardsProvider.points < totalPoints) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Not enough points for selected items'),
          backgroundColor: Colors.red,
        )
      );
      return;
    }
    
    // Purchase items
    bool success = await _rewardsProvider.spendPoints(totalPoints);
    
    if (success) {
      // Mark items as purchased
      for (var item in selectedItems) {
        await _rewardsProvider.addPurchasedItem(item.id);
        _cartProvider.removeFromCart(item.id);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${selectedItems.length} items purchased!'),
          backgroundColor: Colors.green,
        )
      );
      
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = _cartProvider.cartItems;
    final isAllSelected = cartItems.isNotEmpty && 
                         _cartProvider.selectedItemIds.length == cartItems.length;
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber.shade300,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: Icon(
                isAllSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.white,
              ),
              onPressed: () {
                _cartProvider.toggleSelectAll();
                setState(() {});
              },
              tooltip: isAllSelected ? 'Deselect All' : 'Select All',
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
                
                // Cart items list
                Expanded(
                  child: cartItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined, 
                                size: 80, 
                                color: Colors.amber.withOpacity(0.7)
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Your cart is empty',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Add items from the rewards shop',
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
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            final isSelected = _cartProvider.isSelected(item.id);
                            final canAfford = _rewardsProvider.points >= item.points;
                            
                            return CartItemCard(
                              item: item,
                              isSelected: isSelected,
                              canAfford: canAfford,
                              onToggleSelection: () {
                                _cartProvider.toggleSelection(item.id);
                                setState(() {});
                              },
                              onRemove: () {
                                _cartProvider.removeFromCart(item.id);
                                setState(() {});
                              },
                            );
                          },
                        ),
                ),
                
                // Checkout section
                if (cartItems.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selected Items',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${_cartProvider.selectedItemIds.length}/${cartItems.length}',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Points',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.stars, color: Colors.amber, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  '${_cartProvider.totalSelectedPoints}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _cartProvider.totalSelectedPoints <= _rewardsProvider.points
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _cartProvider.selectedItemIds.isEmpty || 
                                      _cartProvider.totalSelectedPoints > _rewardsProvider.points
                                ? null
                                : _purchaseSelectedItems,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Purchase Selected Items',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final RewardItem item;
  final bool isSelected;
  final bool canAfford;
  final VoidCallback onToggleSelection;
  final VoidCallback onRemove;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.canAfford,
    required this.onToggleSelection,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.amber : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Checkbox
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.amber,
              ),
              onPressed: onToggleSelection,
            ),
          ),
          
          // Image container
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: getColorForCategory(item.category).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Image.asset(
                item.imagePath,
                height: 60,
                width: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
                  Row(
                    children: [
                      Icon(Icons.stars, color: Colors.amber, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '${item.points}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: canAfford ? Colors.black : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Remove button
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: onRemove,
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