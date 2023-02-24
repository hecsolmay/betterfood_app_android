import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';

class ProductDetails extends StatefulWidget {
  final String productName;
  ProductDetails({super.key, required this.productName});

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
  Widget build(BuildContext context) {
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
                image:
                    'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "Tuetano con Ribeye",
                    overflow: TextOverflow.clip,
                    size: 18,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Corte de res cocido en sus jugos, acompañado dcon tuetano y una guarnicion de ensalada",
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  BigText(
                    text: "MX340.00",
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
                  const SizedBox(height: 20),
                  BigText(
                    text: "Ingredientes Extra",
                    size: 15,
                  ),
                  const SizedBox(height: 10),
                  ...widget.extra.map(buildSingleCheckbox).toList(),
                  const SizedBox(height: 25),
                  BigText(
                    text: "Se pueden quitar",
                    size: 15,
                  ),
                  const SizedBox(height: 10),
                  ...widget.remove.map(buildSingleCheckbox).toList()
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const BottomCard(),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => Dismissible(
        key: UniqueKey(),
        background: Container(color: const Color.fromARGB(185, 221, 0, 0)),
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
              onChanged: (value) => setState(() => checkbox.value = value!),
            ),
          ],
        ),
      );
}

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({required this.title, this.value = false});
}
