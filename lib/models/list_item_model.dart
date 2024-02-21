class ListItemModel {
  final String adId;
  final int rate;
  final String model;
  final String year;
  final String? imageUrl;
  bool isFav;

  ListItemModel(
      {required this.adId,
      required this.rate,
      required this.model,
      required this.year,
      this.imageUrl,
      this.isFav = false});
}
