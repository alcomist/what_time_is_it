import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {

  const BigCard({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(message, style: style),
      ),
    );
  }
}