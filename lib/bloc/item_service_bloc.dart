import 'package:rxdart/rxdart.dart';
import 'package:technical_service_flutter/services/item_service.dart';

class ItemServiceBloc {
  String _status = "";
  final ItemService serviceItemService;

  ItemServiceBloc({this.serviceItemService}) {}

  Observable<String> get status => _statusSubject.stream;

  final _statusSubject = BehaviorSubject<String>();

  void getStatus(String code) async {
    var status = await this.serviceItemService.getStatusAsync(code);
    _status = status;
    _statusSubject.sink.add(_status);
  }

  void dispose() {
    _statusSubject.close();
  }
}
