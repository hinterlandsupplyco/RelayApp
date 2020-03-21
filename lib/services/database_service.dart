import '../ioc/dependency_registrar.dart';
import '../data/db/app_database.dart';
import '../data/db/database_provider.dart';

class DatabaseService {
  final String _mainStorageDatabaseName = "appstore.db";
  DatabaseProvider _provider;

  DatabaseService([DatabaseProvider provider]) {
    _provider = provider ?? dependencyLocator<DatabaseProvider>();
  }

  /// Gets the main storage database for the app.
  Future<AppDatabase> getMainStorage() async {
    return await _provider.getLocalDatabase(_mainStorageDatabaseName);
  }
}