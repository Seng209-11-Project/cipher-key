import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password Length",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.toInt().toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
            const Text("32", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
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
            activeColor: Colors.black,
            inactiveColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}