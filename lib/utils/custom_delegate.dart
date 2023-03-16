import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:betterfood_app_android/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox();
    }

    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return FutureBuilder<dynamic>(
      future: productsProvider.getSearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (productsProvider.productsSearched!.isEmpty) {
            return Column(
              children: const [Text("No se encontraron busquedas Not found")],
            );
          } else {
            final products = productsProvider.productsSearched;
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products!.length,
                itemBuilder: (BuildContext context, int index) {
                  var product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetails(product: product),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                          product.description,
                          maxLines: 3,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        trailing: Text('\$${product.price}'),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Column();
  }
}
