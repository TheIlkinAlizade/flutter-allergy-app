import 'package:allergy_app/data/models/allergen_category.dart';
import 'package:allergy_app/data/models/severity.dart';
import 'package:allergy_app/data/models/user_profile.dart';
import 'package:allergy_app/features/profile/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => throw UnimplementedError('profileRepositoryProvider not overridden'),
);

final profileProvider = NotifierProvider<ProfileNotifier, UserProfile>(
  ProfileNotifier.new,
);

class ProfileNotifier extends Notifier<UserProfile> {
  static const defaultSeverity = Severity.moderate;

  @override
  UserProfile build() => ref.read(profileRepositoryProvider).load();

  Future<void> setAllergen(AllergenCategory category, Severity severity) {
    return _update(state.withAllergen(category, severity));
  }

  Future<void> removeAllergen(AllergenCategory category) {
    return _update(state.withoutAllergen(category));
  }

  Future<void> setCrossContamination(bool value) {
    return _update(state.withCrossContamination(value));
  }

  Future<void> _update(UserProfile next) async {
    state = next;
    await ref.read(profileRepositoryProvider).save(next);
  }
}