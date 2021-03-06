
import 'package:get_it/get_it.dart';

class FeatureSwitchService {
  bool isMassOutbreakPathingEnabled() {
    return true;
  }

  static void register() {
    GetIt.I.registerLazySingleton(() => FeatureSwitchService());
  }

  static FeatureSwitchService provide() => GetIt.I.get();
}