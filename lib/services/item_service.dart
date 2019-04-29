import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:technical_service_flutter/model/service_item.dart';

class ItemService {
  Map<String, String> statusMockup = Map<String, String>();

  ItemService() {
    statusMockup.addAll({"abcd": "Pendiente"});
    statusMockup.addAll({"asda": "Reparando"});
  }

  String getStatus(String serviceCode) {
    if (statusMockup[serviceCode] != null) {
      return statusMockup[serviceCode];
    }
    return "Su orden no existe";
  }

  Future<String> getStatusAsync(String serviceCode) async {
    final getItemUrl =
        "http://techservice.gear.host/api/Service/GetServiceItem?itemId=$serviceCode";
    final itemResponse = await http.get(getItemUrl);
    if (itemResponse.statusCode == 200) {
      ServiceItem item = ServiceItem.fromJson(json.decode(itemResponse.body));
      return item.statusName;
    }
    return "No encontrado";
  }
}
