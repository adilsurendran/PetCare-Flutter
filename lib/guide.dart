import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 105, 205),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCUw9lt0KvN3dVNFfXo2VUmhO0w4bhAQjZvg&s',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: const Text('Rabies'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 4),
                  Text('Symptoms:Fear of water,Paralysis'),
                  Text('Experience: 4'),
                ],
              ),
            
            ),
          );
        },
      ),
    );
  }
}
