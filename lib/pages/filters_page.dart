import 'dart:developer';

import 'package:cloth_app/models/filter_model.dart';
import 'package:cloth_app/pages/products_page.dart';
import 'package:cloth_app/providers/product_provider.dart';
import 'package:cloth_app/widgets/filter_chip.dart';
import 'package:cloth_app/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({Key? key}) : super(key: key);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  late final ProductProvider productProvider;
  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Filters",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // productProvider.getFilteredList();
                productProvider.onFilterSubmitEEvent();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ProductsPage();
                  },
                ));
              },
              icon: const Icon(
                Icons.check,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        left: true,
        right: true,
        child: Consumer<ProductProvider>(builder: (context, provider, _) {
          List<FilterModel> list = provider.filterModelList;
          return Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    provider.filterModelList.length,
                    (index) {
                      return Column(
                        children: [
                          getFilterName(list[index].filterName),
                          Spacing.w15,
                          getFIlterList(list[index]),
                        ],
                      );
                    },
                  ),
                ],
              ),
              // Spacer(),
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Color(0x825182ff),
              //           blurRadius: 18,
              //           offset: Offset(0, 4),
              //         ),
              //       ],
              //       color: const Color(0xff376aed),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     alignment: Alignment.center,
              //     child: const Text(
              //       "Apply Filter",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 15.0,
              //         height: 1.42,
              //         //    letterSpacing: 1.5
              //       ),
              //     ),
              //   ),
              // ),
              // Spacing.h20,
            ],
          );
        }),
      ),
    );
  }

  Widget getFIlterList(FilterModel model) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        ...List.generate(model.filterItems.length, (idx) {
          return FilterChips(
            filterName: model.filterName,
            individualFilterName: model.filterItems[idx].individualFilterName,
            isSelected: model.filterItems[idx].isSelected,
          );
        }),
        Spacing.w5
      ],
    );
  }

  Container getFilterName(String filterName) {
    return Container(
        height: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
          ),
        ),
        child: Text(filterName.toUpperCase()));
  }
}
/*    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       color: Color(0xFFF5F5F5),
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             width: 2.0, color: Color(0xFF000000)),
                    //       ),
                    //     ),
                    //     alignment: Alignment.center,
                    //     child: const Text("Brands"),
                    //   ),
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     decoration: const BoxDecoration(
                    //       color: Color(0xFFF5F5F5),
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             width: 2.0, color: Color(0xFF000000)),
                    //       ),
                    //     ),
                    //     child: const Text("Size"),
                    //   ),
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       color: Color(0xFFF5F5F5),
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             width: 2.0, color: Color(0xFF000000)),
                    //       ),
                    //     ),
                    //     alignment: Alignment.center,
                    //     child: const Text("Price"),
                    //   ),
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     decoration: const BoxDecoration(
                    //       color: Color(0xFFF5F5F5),
                    //       border: Border(
                    //         bottom: BorderSide(
                    //             width: .0, color: Color(0xFF000000)),
                    //       ),
                    //     ),
                    //     child: const Text("Discount"),
                    //   ),
                    // ),
                   */