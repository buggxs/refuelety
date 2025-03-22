import 'package:flutter/material.dart';

class FuelPriceCard extends StatelessWidget {
  const FuelPriceCard({
    super.key,
    required this.fuelType,
    required this.price,
    required this.isIncrease,
  });

  final String fuelType;
  final double price;
  final bool isIncrease;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              fuelType,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Icon(
                  isIncrease ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: isIncrease ? Colors.red : Colors.green,
                ),
                Text(
                  '${price.toStringAsFixed(2)} €',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: isIncrease ? Colors.red : Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
