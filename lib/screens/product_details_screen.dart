import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, String> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  List<Map<String, String>> reviews = [
    {'name': 'Athi', 'comment': 'Loved this product! Great quality.'},
    {'name': 'Avanya', 'comment': 'Fits perfectly and looks amazing.'},
  ]; // Dummy reviews

  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double unitPrice = double.parse(widget.product['price']!.substring(1)); 
    double totalPrice = unitPrice * quantity;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80), 
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Center(
                    child: Image.asset(
                      widget.product['image']!,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),

                  //  Name and Price
                  Text(
                    widget.product['name']!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    "This ${widget.product['name']}. It's stylish, comfortable, and perfect for any occasion!",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),

                  
                  Row(
                    children: [
                      const Text("Quantity:", style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                        color: Colors.black,
                      ),
                      Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Add to Cart Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/cart', // cart screen
                        arguments: {
                          'name': widget.product['name'],
                          'image': widget.product['image'],
                          'price': unitPrice,
                          'quantity': quantity,
                                                    'description': " description.",
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Reviews Section
                  const Text(
                    "Reviews",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Reviews List
                  reviews.isEmpty
                      ? const Center(
                          child: Text("No reviews yet. Be the first to review!"),
                        )
                      : ListView.builder(
                          shrinkWrap: true, 
                          physics: const NeverScrollableScrollPhysics(), 
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: const Icon(Icons.person, color: Colors.black),
                              ),
                              title: Text(review['name'] ?? 'Anonymous'),
                              subtitle: Text(review['comment'] ?? ''),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),

 
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _reviewController,
                      decoration: const InputDecoration(
                        hintText: "Write a review...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_reviewController.text.isNotEmpty) {
                        setState(() {
                          reviews.add({
                            'name': 'User', 
                            'comment': _reviewController.text,
                          });
                          _reviewController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      "Post",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

                         
