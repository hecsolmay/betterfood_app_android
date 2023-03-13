import 'package:betterfood_app_android/dtos/providers/customprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/response/productresponse.dart';
import 'package:betterfood_app_android/widgets/ingredents.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductResponseDto product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();

    Provider.of<ProductsProvider>(context, listen: false)
        .getById(widget.product.id);
    Provider.of<CustomIngredentsProvider>(context, listen: false).resetState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final productdetail = productProvider.productdetail;
    final product = widget.product;

    final requiredIngredents =
        productdetail?.ingredents.where((e) => e.required);
    final extraIngredents = productdetail?.ingredents
        .where((e) => !e.required && e.extraPrice != 0);
    final removeIngredents = productdetail?.ingredents
            .where((e) => !e.required && e.extraPrice == 0) ??
        [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color.fromRGBO(186, 0, 0, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_outlined))
              ],
            ),
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeInImage.assetNetwork(
                width: double.maxFinite,
                height: 280,
                placeholder: 'assets/loading.gif',
                image: product.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                      text: product.name,
                      overflow: TextOverflow.clip,
                      size: 18),
                  const SizedBox(height: 20),
                  Text(
                    product.description,
                    style: const TextStyle(
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BigText(
                    text: "MX ${product.price}",
                    size: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 1,
                    width: 340,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  ),
                  productProvider.isLoading
                      ? const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            productdetail!.ingredents.isNotEmpty
                                ? IngredentsList(
                                    ingredents: requiredIngredents,
                                    text: "Ingredientes",
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 15,
                            ),
                            extraIngredents!.isNotEmpty
                                ? ListExtraIngredents(
                                    extraIngredents: extraIngredents)
                                : const SizedBox(),
                            removeIngredents.isNotEmpty
                                ? ListRemoveIngredents(
                                    removeIngredents: removeIngredents)
                                : const SizedBox(),
                          ],
                        )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomCard(price: product.price),
    );
  }
}
