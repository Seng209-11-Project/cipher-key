import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class PasswordLengthSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const PasswordLengthSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.passwordLength,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: cs.primary, // THEMED
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.toInt().toString(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: cs.primary, // THEMED
              ),
            ),
            Text(
              "32",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: cs.primary, // THEMED
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: value,
            min: 4,
            max: 32,
            activeColor: cs.primary, // THEMED
            inactiveColor: cs.secondary.withOpacity(0.3), // THEMED
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
