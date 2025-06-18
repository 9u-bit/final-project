import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/collection_products.dart';
import '/ui/home.dart';

class ProductClicked extends StatefulWidget {
  final Product product;

  const ProductClicked({super.key, required this.product});

  @override
  State<ProductClicked> createState() => _ProductClickedState();
}

class _ProductClickedState extends State<ProductClicked> {
  int quantity = 1;

  // Width and height of prints (puedes cambiar esto)
  final Map<String, List<double>> printSizes = {
    'A5': [14.8, 21.0],
    'A4': [21.0, 29.7],
    'A3': [29.7, 42.0],
    'A2': [42.0, 59.4],
  };

  // Default size
  String selectedSize = 'A4';

  void _increment() => setState(() => quantity++);
  void _decrement() => setState(() {
    if (quantity > 1) quantity--;
  });

  void _launchInstagram() async {
    const url = 'https://www.instagram.com/s.ese.art?igsh=MWdlMjNzM2F5aHM0aQ==';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir Instagram')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final totalPrice = product.price * quantity;
    final selectedDimensions = printSizes[selectedSize]!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E1A47),
        elevation: 0,
        titleSpacing: 24,
        title: const Text(
          'S.ESE.ART',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          _buildMenuItem(context, 'Home', const HomePage()), // home.dart
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(150, 30, 150, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.image,
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Size selector
            Text('Selecciona el tamaño:', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children:
                  printSizes.keys.map((size) {
                    final isSelected = size == selectedSize;
                    return ChoiceChip(
                      label: Text(size),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedSize = size;
                          });
                        }
                      },
                    );
                  }).toList(),
            ),

            const SizedBox(height: 16),
            Text(
              'Dimensiones seleccionadas: ${selectedDimensions[0]}cm x ${selectedDimensions[1]}cm',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            // Quantity
            Row(
              children: [
                const Text('Cantidad:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                ),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
                IconButton(onPressed: _increment, icon: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),

            // Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Unfinished logic here!
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added to cart!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E1A47),
                  ),
                  child: const Text('Add to cart'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: _launchInstagram,
                  child: const Text('Contact us on Instagram!'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
