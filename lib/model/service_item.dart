class ServiceItem {
  String id;
  String productName;
  String clientName;
  int status;
  String statusName;

  ServiceItem(
      {this.id,
      this.productName,
      this.clientName,
      this.status,
      this.statusName});

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
        clientName: json["clientName"],
        id: json["id"],
        productName: json["productName"],
        status: json["status"],
        statusName: json["statusName"]);
  }
}
