import 'package:cloth_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChips extends StatefulWidget {
  final String individualFilterName;
  final String filterName;
  final bool isSelected;
  const FilterChips({
    Key? key,
    required this.individualFilterName,
    required this.filterName,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  late final ProductProvider provider;
  @override
  void initState() {
    provider = Provider.of<ProductProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.black38,
        backgroundColor: Colors.white,
        selectedColor: Colors.blue.shade50,
        selected: widget.isSelected,
        label: Text(widget.individualFilterName),
        onSelected: (bool selected) {
          provider.onChipClicked(
            filterName: widget.filterName,
            individualFilterName: widget.individualFilterName,
          );
        });
  }
}
