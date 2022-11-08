import 'package:flutter/material.dart';
import '../utils/shared_prefs.dart';
import '../services/cloud_service.dart';
import '../storage/cloud_storage.dart';

import '../core/constants.dart';
import '../models/cloud_config.dart';

class CloudConfigProvider with ChangeNotifier {
  CloudConfig? _config;
  late CloudStorageDB cloudStorage;
  CloudConfigProvider() {
    _config = null;
    cloudStorage = SharedPrefs().cloudStorage;
  }

  CloudConfig? get config {
    return _config;
  }

  Future<CloudConfig?> getConfig() {
    return CloudService()
        .getConfig(Constants.cloudServiceKey)
        .catchError((e) => throw e);
  }
}
