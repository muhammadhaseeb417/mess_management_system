import 'package:get_it/get_it.dart';

import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/media_service.dart';
import '../services/storage_servive.dart';

Future<void> RegisterServics() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
  getIt.registerSingleton<StorageServive>(
    StorageServive(),
  );
}

String createChatId({required String uid1, required String uid2}) {
  var bothIDs = [uid1, uid2];
  bothIDs.sort();
  String chatId = bothIDs.fold(
    "",
    (preID, uid) => "$preID$uid",
  );
  return chatId;
}
