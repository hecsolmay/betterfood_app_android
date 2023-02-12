import 'package:betterfood_app_android/widgets/appbar.dart';
import 'package:betterfood_app_android/widgets/carrusel_img.dart';
import 'package:betterfood_app_android/widgets/categoriacard.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  onSearch(String search) {
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarSearch(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: constraints.maxWidth > 600
                    ? const EdgeInsets.symmetric(horizontal: 60)
                    : const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Bienvenido a ',
                          style: TextStyle(
                              fontSize: 25, color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'BETTER FOOD',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromRGBO(186, 0, 0, 1)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CarruselImg(),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        Categoria(
                          nameCategoria: 'Recomenados',
                          routeName: 'wgsrt',
                          urlImg:
                              'https://cdn.pixabay.com/photo/2017/01/26/02/06/platter-2009590_960_720.jpg',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Categoria(
                          nameCategoria: 'Ensaladas',
                          routeName: 'wgsrt',
                          urlImg:
                              'https://cdn.pixabay.com/photo/2015/05/31/12/58/spinach-791629_960_720.jpg',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Categoria(
                          nameCategoria: 'Postres',
                          routeName: 'wgsrt',
                          urlImg:
                              'https://cdn.pixabay.com/photo/2017/01/16/17/45/pancake-1984716_1280.jpg',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: const [
                            Categoria(
                              nameCategoria: 'Carnes',
                              routeName: '/categories',
                              urlImg:
                                  'https://cdn.pixabay.com/photo/2016/03/05/23/02/barbecue-1239434_960_720.jpg',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Categoria(
                              nameCategoria: 'Pastas',
                              routeName: 'wgsrt',
                              urlImg:
                                  'https://cdn.pixabay.com/photo/2016/02/05/15/34/pasta-1181189_960_720.jpg',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Categoria(
                              nameCategoria: 'Bebidas',
                              routeName: 'wgsrt',
                              urlImg:
                              'https://cdn.pixabay.com/photo/2016/10/22/20/34/wines-1761613_960_720.jpg',
                            )
                          ]
                        )
                      ]
                    )
                  ]
                )
              )
            ] 
          );
        }
      )

    );   
  }
}

