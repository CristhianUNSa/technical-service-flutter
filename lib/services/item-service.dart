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
}
