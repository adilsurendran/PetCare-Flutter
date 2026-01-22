// import 'package:flutter/material.dart';
// import 'package:petcareapp/market_manager.dart';
// import 'package:petcareapp/market_models.dart';

// class BuyProductsPage extends StatefulWidget {
//   const BuyProductsPage({super.key});

//   @override
//   State<BuyProductsPage> createState() => _BuyProductsPageState();
// }

// class _BuyProductsPageState extends State<BuyProductsPage> {
//   final TextEditingController _searchController = TextEditingController();
  
//   String _selectedCategory = "All";
//   RangeValues _priceRange = const RangeValues(0, 5000);

//   final List<String> _categories = ["All", "Food", "Toys", "Accessories", "Medicine"];

//   List<Product> _filteredProducts = [];

//   @override
//   void initState() {
//     super.initState();
//     _updateList();
//     _searchController.addListener(_updateList);
//   }

//   void _updateList() {
//     final query = _searchController.text.toLowerCase();
    
//     setState(() {
//       _filteredProducts = MarketManager().products.where((prod) {
//         final matchesQuery = prod.name.toLowerCase().contains(query);
//         final matchesCategory = _selectedCategory == "All" || prod.category == _selectedCategory;
//         final matchesPrice = prod.price >= _priceRange.start && prod.price <= _priceRange.end;
//         return matchesQuery && matchesCategory && matchesPrice;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text("Buy Products", style: TextStyle(color: Color.fromARGB(255, 0, 150, 136), fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromARGB(255, 218, 98, 17)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
//             onPressed: _showFilterBottomSheet,
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: "Search products...",
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
          
//           Expanded(
//             child: _filteredProducts.isEmpty
//                 ? const Center(child: Text("No products found"))
//                 : GridView.builder(
//                     padding: const EdgeInsets.all(16),
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.7,
//                       mainAxisSpacing: 16,
//                       crossAxisSpacing: 16,
//                     ),
//                     itemCount: _filteredProducts.length,
//                     itemBuilder: (context, index) {
//                       return _buildProductCard(_filteredProducts[index]);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductCard(Product product) {
//     return GestureDetector(
//       onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 child: Image.network(product.image, fit: BoxFit.cover, width: double.infinity),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("₹${product.price.toInt()}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
//                       Row(
//                         children: [
//                           const Icon(Icons.star, size: 14, color: Colors.amber),
//                           Text("${product.rating}", style: const TextStyle(fontSize: 12)),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//    void _showFilterBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//       builder: (_) {
//          return StatefulBuilder(
//            builder: (context, setStateSheet) {
//              return Padding(
//                padding: const EdgeInsets.all(24),
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    const Text("Filter Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                    const SizedBox(height: 20),
                   
//                    const Text("Category", style: TextStyle(fontWeight: FontWeight.w600)),
//                    DropdownButton<String>(
//                      value: _selectedCategory,
//                      isExpanded: true,
//                      items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//                      onChanged: (val) => setStateSheet(() => _selectedCategory = val!),
//                    ),
                   
//                    const SizedBox(height: 16),
//                    const Text("Price Range", style: TextStyle(fontWeight: FontWeight.w600)),
//                    RangeSlider(
//                      values: _priceRange,
//                      min: 0,
//                      max: 10000,
//                      divisions: 20,
//                      activeColor: Colors.teal,
//                      labels: RangeLabels("₹${_priceRange.start.toInt()}", "₹${_priceRange.end.toInt()}"),
//                      onChanged: (val) => setStateSheet(() => _priceRange = val),
//                    ),

//                    const SizedBox(height: 24),
//                    SizedBox(
//                      width: double.infinity,
//                      child: ElevatedButton(
//                        style: ElevatedButton.styleFrom(
//                          backgroundColor: Colors.teal,
//                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                          padding: const EdgeInsets.symmetric(vertical: 16),
//                        ),
//                        onPressed: () {
//                          _updateList();
//                          Navigator.pop(context);
//                        },
//                        child: const Text("Apply Filters", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                      ),
//                    ),
//                  ],
//                ),
//              );
//            }
//          );
//       },
//     );
//   }
// }

// class ProductDetailPage extends StatelessWidget {
//   final Product product;
//   const ProductDetailPage({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromARGB(255, 218, 98, 17)),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text("Product Details", style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.network(product.image, height: 300, width: double.infinity, fit: BoxFit.cover),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   Text("₹${product.price.toInt()}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       const Icon(Icons.category_rounded, color: Colors.teal),
//                       const SizedBox(width: 8),
//                       Text(product.category),
//                       const SizedBox(width: 24),
//                        const Icon(Icons.store, color: Colors.orange),
//                       const SizedBox(width: 8),
//                       Text(product.shopName),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   Text(product.description.isNotEmpty ? product.description : "No description available.", style: const TextStyle(color: Colors.grey, height: 1.5)),
                  
//                   const SizedBox(height: 40),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       onPressed: () {},
//                       child: const Text("Buy Now", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'my_orders_page.dart';

// class BuyProductsPage extends StatefulWidget {
//   const BuyProductsPage({super.key});

//   @override
//   State<BuyProductsPage> createState() => _BuyProductsPageState();
// }

// class _BuyProductsPageState extends State<BuyProductsPage> {
//   final TextEditingController _searchController = TextEditingController();

//   List<dynamic> _products = [];
//   List<dynamic> _filteredProducts = [];
//   bool _loading = true;

//   String _selectedCategory = "All";
//   RangeValues _priceRange = const RangeValues(0, 10000);

//   final List<String> _categories = [
//     "All",
//     "food",
//     "toys",
//     "accessories",
//     "medicine"
//   ];

//   final String baseUrl = "http://localhost:5000/api";
//   final String uploadsUrl = "http://localhost:5000/uploads";

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//     _searchController.addListener(_applyFilters);
//   }

//   Future<void> fetchProducts() async {
//     try {
//       final res = await http.get(Uri.parse("$baseUrl/allpro"));
//       final data = jsonDecode(res.body);

//       setState(() {
//         _products = data["products"] ?? [];
//         _filteredProducts = _products;
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() => _loading = false);
//     }
//   }

//   void _applyFilters() {
//     final query = _searchController.text.toLowerCase();

//     setState(() {
//       _filteredProducts = _products.where((p) {
//         final name = p["ProductName"].toString().toLowerCase();
//         final category = p["category"];
//         final price = double.parse(p["price"].toString());

//         final matchesSearch = name.contains(query);
//         final matchesCategory =
//             _selectedCategory == "All" || category == _selectedCategory;
//         final matchesPrice =
//             price >= _priceRange.start && price <= _priceRange.end;

//         return matchesSearch && matchesCategory && matchesPrice;
//       }).toList();
//     });
//   }

//   Future<void> buyNow(dynamic product) async {
//     final userId = await _getUserId();
//     if (userId == null) return;

//     await http.post(
//       Uri.parse("$baseUrl/bookpro/$userId"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "productId": product["_id"],
//         "sellerLoginId": product["userId"],
//         "quantity": 1,
//       }),
//     );

//     ScaffoldMessenger.of(context)
//         .showSnackBar(const SnackBar(content: Text("Product booked")));
//   }

//   Future<String?> _getUserId() async {
//     // adjust based on your auth storage
//     return "USER_ID_FROM_STORAGE";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text(
//           "Buy Products",
//           style: TextStyle(
//             color: Colors.teal,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: BackButton(color: Colors.orange),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const MyOrdersPage()),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
//             onPressed: _showFilterSheet,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: "Search products...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//                     padding: const EdgeInsets.all(16),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemCount: _filteredProducts.length,
//                     itemBuilder: (_, i) =>
//                         _buildProductCard(_filteredProducts[i]),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductCard(dynamic p) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(20)),
//               child: Image.network(
//                 "$uploadsUrl/${p["screenshots"][0]}",
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   p["ProductName"],
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "₹${p["price"]}",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.teal),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => buyNow(p),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text("Buy Now"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showFilterSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//       builder: (_) {
//         return StatefulBuilder(
//           builder: (_, setSheet) {
//             return Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text("Filter Products",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   DropdownButton<String>(
//                     value: _selectedCategory,
//                     isExpanded: true,
//                     items: _categories
//                         .map((c) =>
//                             DropdownMenuItem(value: c, child: Text(c)))
//                         .toList(),
//                     onChanged: (v) => setSheet(() {
//                       _selectedCategory = v!;
//                     }),
//                   ),
//                   RangeSlider(
//                     values: _priceRange,
//                     min: 0,
//                     max: 10000,
//                     divisions: 20,
//                     labels: RangeLabels(
//                         "₹${_priceRange.start.toInt()}",
//                         "₹${_priceRange.end.toInt()}"),
//                     onChanged: (v) => setSheet(() => _priceRange = v),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       _applyFilters();
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal),
//                     child: const Text("Apply Filters"),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:petcareapp/login.dart';
// import 'package:petcareapp/register.dart';

// import 'my_orders_page.dart';

// class BuyProductsPage extends StatefulWidget {
//   const BuyProductsPage({super.key});

//   @override
//   State<BuyProductsPage> createState() => _BuyProductsPageState();
// }

// class _BuyProductsPageState extends State<BuyProductsPage> {
//   final TextEditingController _searchController = TextEditingController();

//   List<dynamic> _products = [];
//   List<dynamic> _filteredProducts = [];
//   bool _loading = true;

//   String _selectedCategory = "All";
//   RangeValues _priceRange = const RangeValues(0, 10000);

//   final List<String> _categories = [
//     "All",
//     "food",
//     "toys",
//     "accessories",
//     "medicine"
//   ];



//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//     _searchController.addListener(_applyFilters);
//   }

//   Future<void> fetchProducts() async {
//     try {
//       final res = await dio.get("$baseUrl/api/allpro");
//       final data = res.data;
//       // print(res.data);

//       setState(() {
//         _products = data["products"] ?? [];
//         _filteredProducts = _products;
//         _loading = false;
//       });
//     } catch (e) {
//       print(e);
//       setState(() => _loading = false);
//     }
//   }

//   void _applyFilters() {
//     final query = _searchController.text.toLowerCase();

//     setState(() {
//       _filteredProducts = _products.where((p) {
//         final name = p["ProductName"].toString().toLowerCase();
//         final category = p["category"];
//         final price = double.parse(p["price"].toString());

//         final matchesSearch = name.contains(query);
//         final matchesCategory =
//             _selectedCategory == "All" || category == _selectedCategory;
//         final matchesPrice =
//             price >= _priceRange.start && price <= _priceRange.end;

//         return matchesSearch && matchesCategory && matchesPrice;
//       }).toList();
//     });
//   }

//   Future<void> buyNow(dynamic product) async {
//   try {
//     final response = await dio.post(
//       "$baseUrl/api/bookpro/$usrid",
//       data: {
//         "productId": product["_id"],
//         "sellerLoginId": product["userId"],
//         "quantity": 1,
//       },
//     );

//     print(response.data);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Product booked")),
//     );

//   } on DioException catch (e) {
//     String errorMessage = "Something went wrong";

//     if (e.response != null) {
//       // Backend error message
//       errorMessage = e.response?.data["message"] ??
//           e.response?.statusMessage ??
//           "Server error";
      
//       print("Status code: ${e.response?.statusCode}");
//       print("Error data: ${e.response?.data}");
//     } else {
//       // No response (network error, timeout, etc.)
//       errorMessage = e.message ?? "Network error";
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(errorMessage)),
//     );

//   } catch (e) {
//     // Any other unexpected error
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Unexpected error: $e")),
//     );
//   }
// }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text(
//           "Buy Products",
//           style: TextStyle(
//             color: Colors.teal,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: BackButton(color: Colors.orange),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const MyOrdersPage()),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
//             onPressed: _showFilterSheet,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: "Search products...",
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(16),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : GridView.builder(
//                     padding: const EdgeInsets.all(16),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.7,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemCount: _filteredProducts.length,
//                     itemBuilder: (_, i) =>
//                         _buildProductCard(_filteredProducts[i]),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductCard(dynamic p) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(20)),
//               child: Image.network(
//                 "$baseUrl/uploads/${p["screenshots"][0]}",
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   p["ProductName"],
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "₹${p["price"]}",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.teal),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () => buyNow(p),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.teal,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text("Buy Now"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showFilterSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
//       builder: (_) {
//         return StatefulBuilder(
//           builder: (_, setSheet) {
//             return Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text("Filter Products",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   DropdownButton<String>(
//                     value: _selectedCategory,
//                     isExpanded: true,
//                     items: _categories
//                         .map((c) =>
//                             DropdownMenuItem(value: c, child: Text(c)))
//                         .toList(),
//                     onChanged: (v) => setSheet(() {
//                       _selectedCategory = v!;
//                     }),
//                   ),
//                   RangeSlider(
//                     values: _priceRange,
//                     min: 0,
//                     max: 10000,
//                     divisions: 20,
//                     labels: RangeLabels(
//                         "₹${_priceRange.start.toInt()}",
//                         "₹${_priceRange.end.toInt()}"),
//                     onChanged: (v) => setSheet(() => _priceRange = v),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       _applyFilters();
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.teal),
//                     child: const Text("Apply Filters"),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:petcareapp/login.dart';
import 'package:petcareapp/register.dart';
import 'my_orders_page.dart';

class BuyProductsPage extends StatefulWidget {
  const BuyProductsPage({super.key});

  @override
  State<BuyProductsPage> createState() => _BuyProductsPageState();
}

class _BuyProductsPageState extends State<BuyProductsPage> {
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _loading = true;

  String _selectedCategory = "All";
  RangeValues _priceRange = const RangeValues(0, 10000);

  final List<String> _categories = [
    "All",
    "food",
    "toys",
    "accessories",
    "medicine"
  ];

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _searchController.addListener(_applyFilters);
  }

  Future<void> fetchProducts() async {
    try {
      final res = await dio.get("$baseUrl/api/allpro");
      final data = res.data;

      setState(() {
        _products = data["products"] ?? [];
        _filteredProducts = _products;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() => _loading = false);
    }
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredProducts = _products.where((p) {
        final name = p["ProductName"].toString().toLowerCase();
        final category = p["category"];
        final price = double.parse(p["price"].toString());

        final matchesSearch = name.contains(query);
        final matchesCategory =
            _selectedCategory == "All" || category == _selectedCategory;
        final matchesPrice =
            price >= _priceRange.start && price <= _priceRange.end;

        return matchesSearch && matchesCategory && matchesPrice;
      }).toList();
    });
  }

  Future<void> buyNow(dynamic product) async {
    try {
      final response = await dio.post(
        "$baseUrl/api/bookpro/$usrid",
        data: {
          "productId": product["_id"],
          "sellerLoginId": product["userId"],
          "quantity": 1,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product booked")),
      );
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";

      if (e.response != null) {
        errorMessage = e.response?.data["message"] ??
            e.response?.statusMessage ??
            "Server error";
      } else {
        errorMessage = e.message ?? "Network error";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Buy Products",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: Colors.orange),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyOrdersPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (_, i) =>
                        _buildProductCard(_filteredProducts[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(dynamic p) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: p),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  "$baseUrl/uploads/${p["screenshots"][0]}",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p["ProductName"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "₹${p["price"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => buyNow(p),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) {
        return StatefulBuilder(
          builder: (_, setSheet) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Filter Products",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: _categories
                        .map((c) =>
                            DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setSheet(() {
                      _selectedCategory = v!;
                    }),
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 10000,
                    divisions: 20,
                    labels: RangeLabels(
                        "₹${_priceRange.start.toInt()}",
                        "₹${_priceRange.end.toInt()}"),
                    onChanged: (v) => setSheet(() => _priceRange = v),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _applyFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal),
                    child: const Text("Apply Filters"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final dynamic product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.orange),
        title: const Text("Product Details",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "$baseUrl/uploads/${product["screenshots"][0]}",
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["ProductName"],
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹${product["price"]}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.teal),
                      const SizedBox(width: 8),
                      Text(product["category"]),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    product["description"] ?? "No description available",
                    style: const TextStyle(color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
