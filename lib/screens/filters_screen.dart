import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(
    this.currentFilters,
    this.saveFilters,
  );

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] ?? false;
    _lactoseFree = widget.currentFilters['lactose'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool?) updateValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('食事の選択を調整する',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'グルテンフリー食品のみ',
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        _glutenFree = newValue!;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  '乳糖フリー食品のみ',
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _lactoseFree = newValue!;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'ベジタリアンー食品のみ',
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _vegetarian = newValue!;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'ビーガン食品のみ',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue!;
                      },
                    );
                  },
                )
              ],
            ))
          ],
        ));
  }
}
