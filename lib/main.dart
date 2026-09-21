import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _bannerController = PageController();
  int _currentBanner = 0;

  final List<String> bannerImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  final List<String> promoImages = [
    'assets/images/promo1.png',
    'assets/images/promo2.png',
    'assets/images/promo3.png',
    'assets/images/promo4.png',
    'assets/images/promo5.png',
    'assets/images/promo6.png',
  ];

  final List<String> popularCollectionImages = [
    'assets/images/popular1.png',
    'assets/images/popular2.png',
    'assets/images/popular3.png',
    'assets/images/popular4.png',
    'assets/images/popular5.png',
    'assets/images/popular6.png',
  ];

  // ---- Store info data ----
  final List<Map<String, String>> stores = [
    {
      'image': 'assets/images/store1.png',
      'name': 'Lakshmi Sarees',
      'rating': '4.8',
      'desc': 'Discover timeless sarees crafted with elegance and beautiful designs.',
    },
    {
      'image': 'assets/images/store2.png',
      'name': 'Traditonal Looms',
      'rating': '4.5',
      'desc': ' Experience the charm of traditional handlooms woven with heritage and care.',
    },
    {
      'image': 'assets/images/store3.png',
      'name': 'Rajish Textiles',
      'rating': '4.3',
      'desc': 'Explore exquisite textiles bringing together quality, comfort, and classic style.',
    },
  ];

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---- TOP BAR ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/lakshmi.png', width: 32, height: 32),
                        const SizedBox(width: 6),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'la',
                                style: TextStyle(color: Colors.red, fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Xi',
                                style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFEDEDED),
                      child: Icon(Icons.person, color: Colors.black54),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ---- SEARCH BAR ----
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      suffixIcon: Icon(Icons.mic, color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ---- BANNER + DOTS + PROMO ROW (NOT tappable — just a carousel) ----
                SizedBox(
                  height: 265,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 180,
                          child: PageView.builder(
                            controller: _bannerController,
                            itemCount: bannerImages.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentBanner = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  bannerImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  alignment: Alignment.topCenter,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 155,
                        left: 0,
                        right: 0,
                        child: IgnorePointer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(bannerImages.length, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                height: 7,
                                width: _currentBanner == index ? 20 : 8,
                                decoration: BoxDecoration(
                                  color: _currentBanner == index ? Colors.blue : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 175,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: promoImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    promoImages[index],
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ---- POPULAR COLLECTION (THIS is tappable) ----
                const Text(
                  'Popular Collection',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
                ),

                const SizedBox(height: 12),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularCollectionImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        List<String> imagesToShow;
                        List<String>? greenImages;

                        if (index == 0) {
                          imagesToShow = [
                            'assets/images/popular1_1.png',
                            'assets/images/popular1_2.png',
                            'assets/images/popular1_3.png',
                            'assets/images/popular1_4.png',
                          ];
                          greenImages = [
                            'assets/images/popular1_green_1.png',
                            'assets/images/popular1_green_2.png',
                            'assets/images/popular1_green_3.png',
                          ];
                        } else {
                          imagesToShow = List.generate(5, (i) => popularCollectionImages[index]);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              productImages: imagesToShow,
                              altColorImages: greenImages,
                              productName: 'Lakshmi Sarees Ridhi Silk Saree Vana Singaram Design',
                              price: '12000',
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          popularCollectionImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // ---- "more" PILL BUTTON ----
                Center(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                    ),
                    child: const Text('more', style: TextStyle(color: Colors.black87)),
                  ),
                ),

                const SizedBox(height: 24),

                // ---- STORE INFO HEADING ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Store Info',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios, size: 18),
                    ),
                  ],
                ),

                // ---- STORE LIST ----
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    final store = stores[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              store['image']!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(store['name']!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                                    const SizedBox(width: 6),
                                    Text(store['rating']!),
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  store['desc']!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFC94A4A),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), activeIcon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}