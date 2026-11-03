import 'package:allergy_app/data/models/user_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileRepository {
  ProfileRepository(this._box);

  static const boxName = 'profile';
  static const _key = 'user_profile';

  final Box<dynamic> _box;

  UserProfile load() {
    final raw = _box.get(_key);
    if (raw is Map) return UserProfile.fromJson(raw);
    return const UserProfile();
  }

  Future<void> save(UserProfile profile) => _box.put(_key, profile.toJson());
}

Future<Box<dynamic>> openProfileBox() async {
  try {
    return await Hive.openBox<dynamic>(ProfileRepository.boxName);
  } catch (_) {
    await Hive.deleteBoxFromDisk(ProfileRepository.boxName);
    return Hive.openBox<dynamic>(ProfileRepository.boxName);
  }
}