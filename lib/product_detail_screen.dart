import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final List<String> productImages;
  final List<String>? altColorImages;
  final String productName;
  final String price;

  const ProductDetailScreen({
    super.key,
    required this.productImages,
    this.altColorImages,
    required this.productName,
    required this.price,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _imageController = PageController();
  int _currentImage = 0;
  int _selectedColor = 0; // 0 = sandal, 1 = light green

  // ---- Only 2 colors now ----
  final List<Color> colorOptions = [
    const Color(0xFFD9C6A5), // sandal
    Colors.lightGreen,
  ];

  // Decides which image list to show, based on selected color
  List<String> get _currentImages {
    if (_selectedColor == 1 && widget.altColorImages != null) {
      return widget.altColorImages!;
    }
    return widget.productImages;
  }

  void _onColorTap(int index) {
    setState(() {
      _selectedColor = index;
      _currentImage = 0;
    });
    _imageController.jumpToPage(0); // reset carousel to first image of the new color
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _currentImages;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- IMAGE CAROUSEL + BACK BUTTON + "New" BADGE ----
              Stack(
                children: [
                  SizedBox(
                    height: 340,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _imageController,
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() => _currentImage = index);
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 12,
                    left: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black.withOpacity(0.3),
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: Colors.green, size: 10),
                          SizedBox(width: 4),
                          Text('New', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          height: 6,
                          width: _currentImage == index ? 16 : 6,
                          decoration: BoxDecoration(
                            color: _currentImage == index ? Colors.indigo : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    Text(
                      'Handwoven Bridal Silk Saree (${_selectedColor == 1 ? "Green" : "Sandal"})',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 16),

                    // ---- COLOR SELECTOR (only 2 now) ----
                    Row(
                      children: [
                        const Text('color:  ', style: TextStyle(fontSize: 16)),
                        ...List.generate(colorOptions.length, (index) {
                          return GestureDetector(
                            onTap: () => _onColorTap(index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorOptions[index],
                                border: _selectedColor == index
                                    ? Border.all(color: Colors.black, width: 2)
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ---- THUMBNAIL STRIP (updates with selected color too) ----
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() => _currentImage = index);
                              _imageController.jumpToPage(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  images[index],
                                  width: 70,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      '${widget.productName} - ${_selectedColor == 1 ? "Green" : "Sandal"}',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: Colors.indigo,
                            size: 20,
                          );
                        }),
                        const SizedBox(width: 6),
                        const Text('4.0'),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          'Rs.${widget.price}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.local_offer_outlined, size: 16, color: Colors.indigo),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Free Delivery Available',
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.local_shipping_outlined, size: 16, color: Colors.indigo),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 14),
                              children: [
                                TextSpan(text: 'Deliver To: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: 'North street, Near kalkovil, Jakkampatty,Aundipatty,theni-625512',
                                ),
                              ],
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade200,
                          child: const Icon(Icons.edit, size: 16, color: Colors.black54),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}