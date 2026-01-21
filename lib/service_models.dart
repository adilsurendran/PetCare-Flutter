
// class Doctor {
//   final String id;
//   final String name;
//   final String qualification;
//   final String experience;
//   final String image;
//   final double rating;
//   final String location;
//   final bool isVet;
//   final String description;

//   Doctor({
//     required this.id,
//     required this.name,
//     required this.qualification,
//     required this.experience,
//     required this.image,
//     required this.rating,
//     required this.location,
//     this.isVet = false,
//     this.description = "",
//   });
// }

// class PetShop {
//   final String id;
//   final String name;
//   final String location;
//   final String image;
//   final double rating;
//   final String description;
//   final List<String> products;

//   PetShop({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.image,
//     required this.rating,
//     this.description = "",
//     this.products = const [],
//   });
// }

// class ServiceProvider {
//   final String id;
//   final String name;
//   final String category; // Groomer, Trainer, Park
//   final String location;
//   final String image;
//   final double rating;
//   final String description;
//   final Map<String, dynamic> extras; // e.g. distance, isOpen for parks

//   ServiceProvider({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.location,
//     required this.image,
//     required this.rating,
//     this.description = "",
//     this.extras = const {},
//   });
// }


class Doctor {
  final String id;
  final String name;
  final String qualification;
  final String experience;
  final String image;
  final double rating;
  final String location;
  final bool isVet;
  final String description;
  final String docloginId;
  final String phone;

  Doctor({
    required this.id,
    required this.name,
    required this.qualification,
    required this.experience,
    required this.image,
    required this.rating,
    required this.location,
    required this.phone,
    required this.docloginId,
    this.isVet = false,
    this.description = "",
  });
}

class PetShop {
  final String id;
  final String name;
  final String location;
  final String image;
  final double rating;
  final String description;
  final List<String> products;

  PetShop({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    this.description = "",
    this.products = const [],
  });
}

class ServiceProvider {
  final String id;
  final String name;
  final String category;
  final String location;
  final String image;
  final double rating;
  final String description;
  final Map<String, dynamic> extras;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.image,
    required this.rating,
    this.description = "",
    this.extras = const {},
  });
}
