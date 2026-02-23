class AzkarModel {
  String? category;
  String? count;
  String? description;
  String? reference;
  String? zekr;

  AzkarModel(
      {this.category, this.count, this.description, this.reference, this.zekr});

  AzkarModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    zekr = json['zekr'];
  }
}
