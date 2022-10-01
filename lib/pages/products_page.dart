import 'dart:developer';

import 'package:cloth_app/models/filter_model.dart';
import 'package:cloth_app/models/product_model.dart';
import 'package:cloth_app/pages/filters_page.dart';
import 'package:cloth_app/widgets/product.dart';
import 'package:cloth_app/services/firestore_services.dart';
import 'package:cloth_app/widgets/shimmer_loading.dart';
import 'package:cloth_app/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/product_provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductProvider productProvider;

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.init();
    super.initState();
  }

  readJson() async {
    FirestoreServices().getFirestoreData();
    // ProductProvider().getFilterProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<ProductProvider>(builder: (context, provider, _) {
        return Column(
          children: [
            buildAppBar(provider),
            !provider.showLoading
                ? buildProducts(
                    (provider.filterProductsList.isEmpty)
                        ? (provider.productsList)
                        : (provider.filterProductsList),
                  )
                : buildAnimation(),
          ],
        );
      })),
    );
  }

  Widget buildAppBar(ProductProvider provider) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 5),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
          buildTitle(provider),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.menu_open_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                return const FiltersPage();
              }));
              // buildFilterDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget buildTitle(ProductProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "MEN TSHIRT",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (provider.productsList.isNotEmpty)
          Text(
            provider.filterProductsList.isEmpty
                ? provider.productsList.length.toString()
                : provider.filterProductsList.length.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
      ],
    );
  }

  Widget buildAnimation() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ShimmerLoading.square(500, 8);
        },
      ),
    );
  }

  Widget buildProducts(List<ProductModel> products) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return Product(products[index]);
            },
          ),
        ),
      ),
    );
  }
}
