import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/widgets/appbar.dart';
import 'package:betterfood_app_android/widgets/carrusel_img.dart';
import 'package:betterfood_app_android/widgets/categoriacard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
        builder: (context, constraints) => Consumer<CategoryProvider>(
            builder: (context, CategoryProvider, child) =>
            CategoryProvider.isLoading?
            const Center( 
              child: CircularProgressIndicator(),
            )
            : 
            
            // ListView.builder(
            //   itemCount: CategoryProvider.categories?.length,
            //   itemBuilder: (context, index) {
                // final categorias = CategoryProvider.categories?[index];
                // return 
                SingleChildScrollView(
                  child: Column(
                  children: [
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
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 10,
                    ),
                    const CarruselImg(),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 600) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 0.5, // ajustar valor de espaciado en el eje cruzado (horizontal)
                              mainAxisSpacing: 0.5, // ajustar valor de espaciado en el eje principal (vertical)
                             ),
                              itemCount: CategoryProvider.categories?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final category = CategoryProvider.categories?[index];
                                return Padding(
                                  
                                  padding: const EdgeInsets.all(50.0),
                                  child: Container(
                                    
                                    child: Center(child: Categoria(
                                        nameCategoria: '${category?.name}',
                                        routeName: '/categories',
                                        urlImg:
                                            '${category?.imgUrl}',
                                      )),),
                                );
                                 
                              },
                            );
                            
                          } else {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 4,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10, // set to 0 to remove spacing between columns
                              mainAxisSpacing: 10,
                                
                              ),
                              itemCount: CategoryProvider.categories?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final category = CategoryProvider.categories?[index];
                                return Padding(
                                  
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    
                                    child: Center(child: Categoria(
                                        nameCategoria: '${category?.name}',
                                        routeName: '/categories',
                                        urlImg:
                                            '${category?.imgUrl}',
                                      )),),
                                );
                                 
                              },
                            );
                            
                          }
                        }
                      )
                    )
                  ] 
                // );
              // },
              
            )),

         
          )
      )

    );   
  }
}

