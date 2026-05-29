import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../core/services/connectivity_service.dart';

class ConnectivityViewModel extends ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();

  bool _isConnected = true;

  bool get isConnected => _isConnected;

  StreamSubscription? _subscription;

  ConnectivityViewModel() {
    _listenConnection();
  }

  void _listenConnection() {
    _subscription = _connectivityService.connectivityStream.listen((result) {
      final hasInternet = result.first != ConnectivityResult.none;

      if (_isConnected != hasInternet) {
        _isConnected = hasInternet;

        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();

    super.dispose();
  }
}
