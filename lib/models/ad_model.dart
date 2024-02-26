class Ad {
  final String? adId;
  final String make;
  final String model;
  final String year;
  final String transmission;
  final String fuelType;
  final DateTime timeStamp;
  final String uId;
  final int rates;
  final String location;
  List? images;
  bool isFav; 

  Ad({
    this.adId,
    this.isFav=false,
    required this.make,
    required this.model,
    required this.year,
    required this.transmission,
    required this.timeStamp,
    required this.uId,
    required this.rates,
    required this.location,
    required this.fuelType,
    this.images
  });

    // Convert an Ad object to a map
  Map<String, dynamic> toMap() {
    return {
      'adId': adId,
      'make': make,
      'model': model,
      'year': year,
      'transmission': transmission,
      'fuelType': fuelType,
      'timeStamp': timeStamp,
      'userId': uId,
      'rates': rates,
      'location': location,
      'isFav': isFav,
      'images': images,
    };
  }

  // Create an Ad object from a map
  static Ad fromMap(Map<String, dynamic> map) {
    return Ad(
      adId: map['adId'],
      make: map['make'],
      model: map['model'],
      year: map['year'],
      transmission: map['transmission'],
      fuelType: map['fuelType'],
      timeStamp: map['timeStamp'],
      uId: map['userId'],
      rates: map['rates'],
      location: map['location'],
      isFav: map['isFav'],
      images: List<String>.from(map['images']),
    );
  }
}
