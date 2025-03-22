import 'package:flutter/material.dart';
import 'package:refuelety/components/map_view/cubit/cubit/filter_state.dart';

class MapFilterScreen extends StatelessWidget {
  const MapFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<SearchMode> searchModes = SearchMode.values;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text('Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Suchmodus'),
            ...List.generate(searchModes.length, (int index) {
              final SearchMode searchMmode = searchModes[index];
              return RadioListTile<SearchMode>(
                title: Text(searchMmode.name.toString().split('.').last),
                value: searchMmode,
                groupValue: SearchMode.location,
                onChanged: (SearchMode? value) {},
              );
            }),
            const Text('Sorte'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FilterChip(
                  label: const Text('E10'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('E10'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('E10'),
                  onSelected: (bool value) {},
                ),
                FilterChip(
                  label: const Text('E10'),
                  onSelected: (bool value) {},
                ),
              ],
            ),
            const Text(
              'Umkreis',
            ),
            Slider(
              value: 5,
              onChanged: (double value) {},
              min: 1,
              max: 100,
              divisions: 100,
              label: '5 km',
            ),
            const Text('Eigene Filter'),
          ],
        ),
      ),
    );
  }
}
