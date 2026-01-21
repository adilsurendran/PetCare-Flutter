import 'package:flutter/material.dart';
import 'package:petcareapp/service_models.dart';
import 'package:petcareapp/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailPage extends StatelessWidget {
  final PetShop shop;

  const ShopDetailPage({super.key, required this.shop});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back_ios_new, color: Color.fromARGB(250, 218, 98, 17)),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                shop.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            shop.name,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.orange, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                shop.rating.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          shop.location,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    const Text(
                      "About Shop",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      shop.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                     const SizedBox(height: 20),
                     const Text(
                      "Available Products",
                        style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                     ),
                     const SizedBox(height: 10),
                     Wrap(
                       spacing: 10,
                       runSpacing: 10,
                       children: shop.products.map((p) => Chip(
                         label: Text(p),
                         backgroundColor: Colors.orange.shade50,
                         labelStyle: const TextStyle(color: Color.fromARGB(250, 218, 98, 17)),
                       )).toList(),
                     ),

                     const SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            )
          ]
        ),
         child: Row(
           children: [
             // CALL BUTTON
             Expanded(
               child: SizedBox(
                 height: 55,
                 child: ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white,
                     foregroundColor: const Color.fromARGB(250, 218, 98, 17),
                     side: const BorderSide(color: Color.fromARGB(250, 218, 98, 17), width: 1.5),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                     elevation: 0,
                   ),
                   icon: const Icon(Icons.call),
                   label: const Text(
                     "Call",
                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                   ),
                   onPressed: () => _makePhoneCall('1234567890'),
                 ),
               ),
             ),
             const SizedBox(width: 16),
             // CHAT BUTTON
             Expanded(
               child: SizedBox(
                 height: 55,
                 child: ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color.fromARGB(250, 218, 98, 17),
                     foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                     elevation: 5,
                   ),
                   icon: const Icon(Icons.chat_bubble_outline),
                   label: const Text(
                     "Chat",
                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                   ),
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(
                       name: shop.name, 
                       image: shop.image,
                       type: 'shop',
                       id: shop.id,
                       fromProfile: true,
                       docloginId: "kjevn",
                     )));
                   },
                 ),
               ),
             ),
           ],
         ),
      ),
    );
  }
}
