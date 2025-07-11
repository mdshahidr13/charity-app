import 'package:flutter/material.dart';
import '../models/client.dart';

class ClientProvider extends ChangeNotifier {
  final List<Client> _clients = [];

  List<Client> get clients => List.unmodifiable(_clients);

  void addClient(Client client) {
    _clients.add(client);
    notifyListeners();
  }

  List<Client> filterByStatus(String status) {
    if (status == 'All') return clients;
    return _clients.where((c) => c.status == status).toList();
  }
} 