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

  Ad({
    this.adId,
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
}
