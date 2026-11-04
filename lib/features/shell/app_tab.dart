import 'package:allergy_app/features/profile/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppTab { scan, history, profile, settings }

final selectedTabProvider = NotifierProvider<SelectedTabNotifier, AppTab>(
  SelectedTabNotifier.new,
);

class SelectedTabNotifier extends Notifier<AppTab> {
  @override
  AppTab build() {
    return ref.read(profileProvider).allergens.isEmpty
        ? AppTab.profile
        : AppTab.scan;
  }

  void select(AppTab tab) => state = tab;
}