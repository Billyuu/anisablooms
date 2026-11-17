
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color primary = Color(0xFF245638);
  static const Color sage = Color(0xFFE5F1E2);
  static const Color background = Color(0xFFF5F8F1);
  static const Color pink = Color(0xFFE9A4B7);

  final List<Map<String, dynamic>> products = const [
    {
      'name': 'Sweet Pink Bouquet',
      'description': 'Buket mawar pink premium',
      'price': 85000,
      'category': 'Best Seller',
      'image':
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=600',
    },
    {
      'name': 'White Elegance',
      'description': 'Buket bunga putih',
      'price': 95000,
      'category': 'Premium',
      'image':
          'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=600',
    },
    {
      'name': 'Sunflower Smile',
      'description': 'Buket bunga matahari',
      'price': 75000,
      'category': 'Favorite',
      'image':
          'https://images.unsplash.com/photo-1508610048659-a06b669e3321?w=600',
    },
    {
      'name': 'Pastel Dream',
      'description': 'Buket pastel aesthetic',
      'price': 110000,
      'category': 'New',
      'image':
          'https://images.unsplash.com/photo-1525310072745-f49212b5ac6d?w=600',
    },
    {
      'name': 'Baby Breath',
      'description': 'Buket baby breath',
      'price': 65000,
      'category': 'Favorite',
      'image':
          'https://images.unsplash.com/photo-1494972308805-463bc619d34e?w=600',
    },
    {
      'name': 'Luxury Bouquet',
      'description': 'Buket bunga eksklusif',
      'price': 150000,
      'category': 'Premium',
      'image':
          'https://images.unsplash.com/photo-1563241527-3004b7be0ffd?w=600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    int cartCount = 0;
    int totalPrice = 0;
    int selectedCategory = 0;
    int selectedNav = 0;

    final categories = [
      'Semua',
      'Best Seller',
      'Premium',
      'Favorite',
      'New',
    ];

    return Scaffold(
      backgroundColor: background,
      body: StatefulBuilder(
        builder: (context, setState) {
          final filteredProducts = selectedCategory == 0
              ? products
              : products
                  .where((p) =>
                      p['category'] == categories[selectedCategory])
                  .toList();

          return SafeArea(
            child: Column(
              children: [
                // HEADER
                _buildHeader(),

                // SEARCH BAR
                _buildSearch(),

                // CATEGORY
                _buildCategories(
                  categories,
                  selectedCategory,
                  (index) {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                ),

                // PRODUCT TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Pilihan Buket',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${filteredProducts.length} Produk',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 9,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Katalog Aktif',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),

                // PRODUCT GRID
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.67,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return _buildProductCard(
                        product,
                        () {
                          setState(() {
                            cartCount++;
                            totalPrice += product['price'] as int;
                          });
                        },
                      );
                    },
                  ),
                ),

                // CART SUMMARY
                _buildCart(
                  cartCount,
                  totalPrice,
                  () {
                    Get.snackbar(
                      'Keranjang',
                      'Lanjutkan ke halaman pembayaran',
                      backgroundColor: sage,
                      colorText: primary,
                    );
                  },
                ),

                // BOTTOM NAVIGATION
                _buildBottomNav(
                  selectedNav,
                  (index) {
                    setState(() {
                      selectedNav = index;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: sage,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.local_florist,
              color: primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BloomPOS',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Kasir',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 8,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 10,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 21,
            backgroundColor: pink.withOpacity(0.3),
            child: const Icon(
              Icons.person,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  // SEARCH
  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Cari nama buket atau produk...',
                  hintStyle: TextStyle(fontSize: 12),
                  prefixIcon: Icon(
                    Icons.search,
                    color: primary,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          _searchButton(Icons.qr_code_scanner),
          const SizedBox(width: 8),
          _searchButton(Icons.tune),
        ],
      ),
    );
  }

  Widget _searchButton(IconData icon) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: sage,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: primary),
    );
  }

  // CATEGORY
  Widget _buildCategories(
    List<String> categories,
    int selected,
    Function(int) onSelect,
  ) {
    return SizedBox(
      height: 53,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 9,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final active = selected == index;

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? primary : Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // PRODUCT CARD
  Widget _buildProductCard(
    Map<String, dynamic> product,
    VoidCallback onAdd,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: sage,
                      child: const Icon(
                        Icons.local_florist,
                        color: primary,
                        size: 55,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 9,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product['category'],
                      style: const TextStyle(
                        color: primary,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263D2D),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  product['description'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Harga',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            _formatPrice(product['price']),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: onAdd,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CART SUMMARY
  Widget _buildCart(
    int count,
    int total,
    VoidCallback onCheckout,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 47,
            width: 47,
            decoration: BoxDecoration(
              color: sage,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: primary,
              size: 25,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$count Item dalam keranjang',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _formatPrice(total),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: count == 0 ? null : onCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB23A59),
              disabledBackgroundColor: Colors.grey.shade300,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: const Row(
              children: [
                Text(
                  'Lanjut',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget _buildBottomNav(
    int selected,
    Function(int) onSelect,
  ) {
    final items = [
      {'icon': Icons.point_of_sale, 'label': 'Kasir'},
      {'icon': Icons.receipt_long, 'label': 'Pesanan'},
      {'icon': Icons.history, 'label': 'Riwayat'},
      {'icon': Icons.bar_chart, 'label': 'Shift'},
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final active = selected == index;

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: active ? sage : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[index]['icon'] as IconData,
                    color: active ? primary : Colors.grey,
                    size: 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    items[index]['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: active
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: active ? primary : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // PRICE FORMAT
  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }
}
