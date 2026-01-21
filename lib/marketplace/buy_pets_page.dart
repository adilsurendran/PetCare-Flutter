import 'package:flutter/material.dart';
import 'package:petcareapp/market_manager.dart';
import 'package:petcareapp/market_models.dart';
// Reusing Petdetails styling or similar
// If we want a specific detail page for market pets, we might need a new one or reuse.
// For now I'll create a simple detail view inside or navigate to a new detail page.

class BuyPetsPage extends StatefulWidget {
  const BuyPetsPage({super.key});

  @override
  State<BuyPetsPage> createState() => _BuyPetsPageState();
}

class _BuyPetsPageState extends State<BuyPetsPage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Filters
  String _selectedType = "All";
  String _selectedGender = "All";
  String _selectedColor = "All";
  RangeValues _ageRange = const RangeValues(0, 24); // Months

  // Available Filter Options
  final List<String> _types = ["All", "Dog", "Cat", "Bird", "Fish"];
  final List<String> _genders = ["All", "Male", "Female"];
  final List<String> _colors = ["All", "White", "Black", "Brown", "Golden", "Cream", "Tricolor"];

  List<MarketPet> _filteredPets = [];

  @override
  void initState() {
    super.initState();
    _updateList();
    _searchController.addListener(_updateList);
  }

  void _updateList() {
    final query = _searchController.text.toLowerCase();
    
    setState(() {
      _filteredPets = MarketManager().pets.where((pet) {
        // Search
        final matchesQuery = pet.name.toLowerCase().contains(query) || 
                             pet.breed.toLowerCase().contains(query);
        
        // Filter Type
        final matchesType = _selectedType == "All" || pet.type == _selectedType;
        
        // Filter Gender
        final matchesGender = _selectedGender == "All" || pet.gender == _selectedGender;
        
        // Filter Color
        final matchesColor = _selectedColor == "All" || pet.color == _selectedColor;

        // Filter Age (Approximate parsing for demo)
        // Assuming age string format "X months"
        int ageMonths = 0;
        try {
          ageMonths = int.parse(pet.age.split(' ')[0]);
        } catch (e) {
          ageMonths = 0;
        }
        final matchesAge = ageMonths >= _ageRange.start && ageMonths <= _ageRange.end;

        return matchesQuery && matchesType && matchesGender && matchesColor && matchesAge;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Buy Pets", style: TextStyle(color: Color.fromARGB(250, 218, 98, 17), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color.fromARGB(250, 218, 98, 17)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: Colors.black),
            onPressed: _showFilterBottomSheet,
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name or breed...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🐾 List
          Expanded(
            child: _filteredPets.isEmpty
                ? const Center(child: Text("No pets found matching criteria"))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: _filteredPets.length,
                    itemBuilder: (context, index) {
                      final pet = _filteredPets[index];
                      return _buildPetCard(pet);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(MarketPet pet) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page
        Navigator.push(context, MaterialPageRoute(builder: (_) => MarketPetDetail(pet: pet)));
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(pet.image, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "₹${pet.price.toInt()}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(pet.breed, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text("${pet.age}, ${pet.gender}", style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Filter Pets", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  _buildDropdown("Type", _types, _selectedType, (val) => setStateSheet(() => _selectedType = val!)),
                  const SizedBox(height: 16),
                  
                  _buildDropdown("Gender", _genders, _selectedGender, (val) => setStateSheet(() => _selectedGender = val!)),
                  const SizedBox(height: 16),
                  
                  _buildDropdown("Color", _colors, _selectedColor, (val) => setStateSheet(() => _selectedColor = val!)),
                  const SizedBox(height: 16),

                  const Text("Age (Months)", style: TextStyle(fontWeight: FontWeight.bold)),
                  RangeSlider(
                    values: _ageRange,
                    min: 0,
                    max: 24,
                    divisions: 24,
                    activeColor: const Color.fromARGB(255, 255, 152, 0),
                    labels: RangeLabels("${_ageRange.start.round()}m", "${_ageRange.end.round()}m"),
                    onChanged: (val) => setStateSheet(() => _ageRange = val),
                  ),
                  
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 152, 0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        _updateList();
                        Navigator.pop(context);
                      },
                      child: const Text("Apply Filters", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDropdown(String label, List<String> items, String current, ValueChanged<String?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        DropdownButton<String>(
          value: current,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
          underline: Container(),
          style: const TextStyle(color: Colors.black, fontSize: 15),
        )
      ],
    );
  }
}

class MarketPetDetail extends StatelessWidget {
  final MarketPet pet;
  const MarketPetDetail({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(pet.image, height: 400, width: double.infinity, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.9,
            builder: (_, scrollController) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pet.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            Text(pet.breed, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                          ],
                        ),
                        Text("₹${pet.price.toInt()}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoBox("Age", pet.age),
                        _infoBox("Gender", pet.gender),
                        _infoBox("Color", pet.color),
                      ],
                    ),

                    const SizedBox(height: 24),
                    
                    const Text("About", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(pet.description.isNotEmpty ? pet.description : "No description provided.", style: const TextStyle(color: Colors.grey, height: 1.5)),

                    const SizedBox(height: 24),

                    // Shop Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.store, color: Colors.orange, size: 40),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Seller", style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              Text(pet.shopName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 218, 98, 17),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      child: const Text("Contact Seller", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: Colors.orange.shade800, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}
