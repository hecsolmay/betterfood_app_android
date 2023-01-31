import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';

class ProductDetails extends StatelessWidget {
  final String productName;
  const ProductDetails({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: CustomScrollView(slivers: [
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
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
                    "https://cdn.pixabay.com/photo/2023/01/08/18/42/road-7705906_960_720.jpg",
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
                    text:
                        "Nombre del Product dfsdf sdmmasmks askmakskas askdmaskmf skdmaks",
                    overflow: TextOverflow.clip,
                    size: 18,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Excepteur sunt commodssa Magna esse veniam enim eiusmod esse labore magna cupidatat. Qui adipisicing laboris enim eiusmod voluptate labore duis cupidatat aliquip fugiat consequat mollit consectetur occaecat. Esse tempor id et cillum eu magna mollit proident. Eu do do occaecat ex. Eu eiusmod qui incididunt Lorem tempor consectetur excepteur.Reprehenderit irure consequat amet sunt duis consequat tempor dolore aliqua consequat duis quis elit velit. Sunt laborum amet sit duis. Reprehenderit excepteur ipsum fugiat est labore. Consectetur magna aliquip deserunt tempor cillum incididunt Lorem esse nisi. Officia nulla nulla minim non eiusmod.o nostrud excepteur. Sit laborum eiusmod dolore occaecat non et. Ex ipsum ea commodo nostrud nulla velit voluptate.",
                    style: TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Excepteur sunt commodssa Magna esse veniam enim eiusmod esse labore magna cupidatat. Qui adipisicing laboris enim eiusmod voluptate labore duis cupidatat aliquip fugiat consequat mollit consectetur occaecat. Esse tempor id et cillum eu magna mollit proident. Eu do do occaecat ex. Eu eiusmod qui incididunt Lorem tempor consectetur excepteur.Reprehenderit irure consequat amet sunt duis consequat tempor dolore aliqua consequat duis quis elit velit. Sunt laborum amet sit duis. Reprehenderit excepteur ipsum fugiat est labore. Consectetur magna aliquip deserunt tempor cillum incididunt Lorem esse nisi. Officia nulla nulla minim non eiusmod.o nostrud excepteur. Sit laborum eiusmod dolore occaecat non et. Ex ipsum ea commodo nostrud nulla velit voluptate.",
                    style: TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Excepteur sunt commodssa Magna esse veniam enim eiusmod esse labore magna cupidatat. Qui adipisicing laboris enim eiusmod voluptate labore duis cupidatat aliquip fugiat consequat mollit consectetur occaecat. Esse tempor id et cillum eu magna mollit proident. Eu do do occaecat ex. Eu eiusmod qui incididunt Lorem tempor consectetur excepteur.Reprehenderit irure consequat amet sunt duis consequat tempor dolore aliqua consequat duis quis elit velit. Sunt laborum amet sit duis. Reprehenderit excepteur ipsum fugiat est labore. Consectetur magna aliquip deserunt tempor cillum incididunt Lorem esse nisi. Officia nulla nulla minim non eiusmod.o nostrud excepteur. Sit laborum eiusmod dolore occaecat non et. Ex ipsum ea commodo nostrud nulla velit voluptate.",
                    style: TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ]));
  }
}

/*
Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: FadeInImage.assetNetwork(
                  width: double.maxFinite,
                  height: 280,
                  placeholder: 'assets/loading.gif',
                  image:
                      "https://cdn.pixabay.com/photo/2023/01/08/18/42/road-7705906_960_720.jpg",
                  fit: BoxFit.cover,
                )),
            Positioned(
              top: 280,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text:
                          "Nombre del Product dfsdf sdmmasmks askmakskas askdmaskmf skdmaks",
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "Excepteur sunt commodo nostrud excepteur. Sit laborum eiusmod dolore occaecat non et. Ex ipsum ea commodo nostrud nulla velit voluptate."),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomCard());
        */