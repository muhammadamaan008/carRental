class ListItemModel {
   String adId;
   int rate;
   String model;
   String year;
   String? imageUrl;
  bool isFav;
  String buyerId;
  String sellerId;

  ListItemModel(
      {required this.adId,
      required this.rate,
      required this.model,
      required this.year,
      required this.buyerId,
      required this.sellerId,
      this.imageUrl,
      this.isFav = false});
}
