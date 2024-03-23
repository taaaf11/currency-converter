import 'package:flutter/material.dart';

import 'dart:math';

class DollarBox extends StatelessWidget {
  const DollarBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: SizedBox(
        child: SizedBox.square(
          dimension: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 10,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Center(
              child: Transform.rotate(
                angle: pi / 4,
                child: Text(
                  '\$',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
