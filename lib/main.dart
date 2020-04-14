import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: _buildChip(),
        ),
      ),
    );
  }

  List<String> _selectedItems = [];
  final _mockItems = ['Alpha', 'Beta', 'Gamma'];

  Widget _buildChip() {
    return ChipsInput(
      key: ValueKey('input'),
      initialValue: <String>[],
      findSuggestions: (query) {
        if (query.isEmpty) return <String>[];

        return _mockItems.where((item) {
          return item.toLowerCase().contains(query.toLowerCase()) &&
              // Don't show already selected items
              !_selectedItems.any((selectedItem) =>
                  selectedItem.toLowerCase() == item.toLowerCase());
        }).toList();
      },
      onChanged: (data) {
        setState(() => _selectedItems = data);
      },
      chipBuilder: (context, state, profile) {
        return InputChip(
          key: ObjectKey(profile),
          label: Text(profile),
          onDeleted: () => state.deleteChip(profile),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        );
      },
      suggestionBuilder: (context, state, profile) {
        return ListTile(
          key: ObjectKey(profile),
          title: Text(profile),
          onTap: () => state.selectSuggestion(profile),
        );
      },
    );
  }
}
