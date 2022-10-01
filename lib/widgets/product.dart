import 'package:cloth_app/models/product_model.dart';
import 'package:cloth_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  ProductModel product;

  Product(this.product, {Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool isWishlist = false;
  late final ProductProvider productProvider;
  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: const Color(0xFFFFFFFF),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Image.network(
                widget.product.productUrl,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.brand,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.product.size.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Consumer<ProductProvider>(
                            builder: (context, provider, _) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                widget.product.isFavorite =
                                    !widget.product.isFavorite;
                              });
                            },
                            child: Icon(
                              widget.product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.black,
                              size: 20,
                            ),
                          );
                        })
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.product.price,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text(
                          '₹ 5000',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.product.discount,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(255, 144, 90, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
