import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  ProductDetails({super.key, required this.id});

  final extra = [
    CheckBoxState(title: "Chile"),
    CheckBoxState(title: "Guacamole"),
    CheckBoxState(title: "Salsa Roja"),
  ];

  final remove = [
    CheckBoxState(title: 'Cebolla'),
    CheckBoxState(title: 'Tomate'),
    CheckBoxState(title: 'Algo'),
  ];

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false).getById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final product = productProvider.productdetail;

    final requiredIngredents = product?.ingredents.where((e) => e.required);
    final extraIngredents =
        product?.ingredents.where((e) => !e.required && e.extraPrice != 0);
    final removeIngredents =
        product?.ingredents.where((e) => !e.required && e.extraPrice == 0);
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
              background: productProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FadeInImage.assetNetwork(
                      width: double.maxFinite,
                      height: 280,
                      placeholder: 'assets/loading.gif',
                      image: product?.imgUrl ??
                          'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: productProvider.isLoading
                ? Container(
                    height: 300,
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: product?.name ?? "nombre",
                          overflow: TextOverflow.clip,
                          size: 18,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product?.description ?? "",
                          style: const TextStyle(
                            height: 1.5,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20),
                        BigText(
                          text: "MX ${product?.price}",
                          size: 18,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          width: 340,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        product!.ingredents.isNotEmpty
                            ? IngredentsList(
                                ingredents: requiredIngredents,
                                text: "incluye",
                              )
                            : const SizedBox(),
                        extraIngredents!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  BigText(
                                    text: "Ingredientes Extra",
                                    size: 15,
                                  ),
                                  const SizedBox(height: 10),
                                  ...extraIngredents
                                      .map(
                                        (e) => buildSingleCheckbox(
                                            CheckBoxState(
                                                title:
                                                    '${e.name}  \$${e.extraPrice}'),
                                            false),
                                      )
                                      .toList(),
                                ],
                              )
                            //   children: extraIngredents
                            //       .map((e) => buildSingleCheckbox(
                            //           CheckBoxState(title: "Hola")))
                            //       .toList(),
                            // )
                            : const SizedBox(),
                        removeIngredents!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  BigText(
                                    text: "Ingredientes removibles",
                                    size: 15,
                                  ),
                                  const SizedBox(height: 10),
                                  ...removeIngredents
                                      .map(
                                        (e) => buildSingleCheckbox(
                                            CheckBoxState(title: e.name), true),
                                      )
                                      .toList(),
                                ],
                              )
                            : const SizedBox(),
                        // const SizedBox(height: 20),
                        // BigText(
                        //   text: "Ingredientes Extra",
                        //   size: 15,
                        // ),
                        // const SizedBox(height: 10),
                        // ...widget.extra.map(buildSingleCheckbox).toList(),
                        // const SizedBox(height: 25),
                        // BigText(
                        //   text: "Se pueden quitar",
                        //   size: 15,
                        // ),
                        // const SizedBox(height: 10),
                        // ...widget.remove.map(buildSingleCheckbox).toList()
                      ],
                    ),
                  ),
          )
        ],
      ),
      bottomNavigationBar: productProvider.isLoading
          ? Container(height: 70)
          : BottomCard(price: product?.price ?? 0),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox, bool dimisible) =>
      dimisible
          ? Dismissible(
              key: UniqueKey(),
              background:
                  Container(color: const Color.fromARGB(185, 221, 0, 0)),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  if (widget.extra.contains(checkbox)) {
                    widget.extra.remove(checkbox);
                  } else {
                    widget.remove.remove(checkbox);
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    checkbox.title,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Checkbox(
                    activeColor: const Color.fromRGBO(186, 0, 0, 1),
                    value: checkbox.value,
                    onChanged: (value) =>
                        setState(() => checkbox.value = value!),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  checkbox.title,
                  style: const TextStyle(fontSize: 15),
                ),
                Checkbox(
                  activeColor: const Color.fromRGBO(186, 0, 0, 1),
                  value: checkbox.value,
                  onChanged: (value) => setState(() => checkbox.value = value!),
                ),
              ],
            );
}

class IngredentsList extends StatelessWidget {
  const IngredentsList({
    super.key,
    required this.ingredents,
    required this.text,
  });

  final Iterable<Ingredent>? ingredents;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        BigText(
          text: text,
          size: 15,
        ),
        const SizedBox(height: 10),
        ...ingredents?.map((e) => UnorderedListItem(text: e.name)).toList() ??
            [],
      ],
    );
  }
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({required this.title, this.value = false});
}

class UnorderedListItem extends StatelessWidget {
  final String text;
  const UnorderedListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "• ",
            style: TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
