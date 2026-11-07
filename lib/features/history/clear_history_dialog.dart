import 'package:allergy_app/features/history/history_provider.dart';
import 'package:allergy_app/shared/l10n_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> confirmAndClearHistory(BuildContext context, WidgetRef ref) async {
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.historyClearTitle),
      content: Text(l10n.historyClearBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.commonClear),
        ),
      ],
    ),
  );
  if (confirmed == true) {
    await ref.read(historyProvider.notifier).clear();
  }
}