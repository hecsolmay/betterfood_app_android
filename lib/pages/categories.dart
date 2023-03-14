import 'package:betterfood_app_android/dtos/providers/categoryprovider.dart';
import 'package:betterfood_app_android/dtos/providers/products_provider.dart';
import 'package:betterfood_app_android/widgets/buttons.dart';
import 'package:betterfood_app_android/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:betterfood_app_android/widgets/orden_list.dart';
import 'package:betterfood_app_android/widgets/products_card.dart';

class Categories extends StatefulWidget {
  final int index;
  const Categories({super.key, required this.index});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    int tabLength = Provider.of<CategoryProvider>(context, listen: false)
            .categories!
            .length +
        1;

    int inicialIndex = widget.index;

    if (inicialIndex == 0) {
      _tabController = TabController(length: tabLength, vsync: this);
    } else {
      _tabController = TabController(
          length: tabLength, vsync: this, initialIndex: inicialIndex);
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final productProvider =
          Provider.of<ProductsProvider>(context, listen: false);

      productProvider.isLoading = true;
      final category = categoryProvider.categories?[inicialIndex - 1];
      productProvider.initGetAllByCategory(category!.id);
    }
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final selectedTabIndex = _tabController.index;
      if (selectedTabIndex != 0) {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        final productProvider =
            Provider.of<ProductsProvider>(context, listen: false);

        if (selectedTabIndex != 0) {
          productProvider.isLoading = true;
          final category = categoryProvider.categories?[selectedTabIndex - 1];
          productProvider.getAllByCategory(category!.id);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final listWidgets = categoryProvider.categories?.map((e) {
          return TabBody(
            productProvider: productProvider,
            id: e.id,
          );
        }).toList() ??
        [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        iconTheme: const IconThemeData(color: Colors.red),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        backgroundColor: Colors.white,
        actions: const [SearchButton(), HelpButton()],
        bottom: TabBar(
          physics: const BouncingScrollPhysics(),
          controller: _tabController,
          isScrollable: true,
          tabs: [
            const Tab(text: "Todos"),
            ...categoryProvider.categories?.map((item) {
                  return Tab(text: item.name);
                }).toList() ??
                []
          ],
          onTap: (int index) {
            if (index == 0) {
            } else {
              final category = categoryProvider.categories?[index - 1];
              final stringId = category!.id;
              productProvider.getAllByCategory(stringId);
            }
          },
          labelColor: const Color.fromRGBO(186, 0, 0, 1),
          unselectedLabelColor: const Color.fromARGB(255, 235, 56, 56),
          indicatorColor: const Color.fromRGBO(186, 0, 0, 1),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2.0,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: [
          productProvider.isLoading || categoryProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ListView.builder(
                      itemCount: productProvider.products?.length,
                      itemBuilder: (context, index) => ProductsCard(
                        product: productProvider.products![index],
                      ),
                    ),
                  ),
                ),
          ...listWidgets,
        ],
      ),
      bottomNavigationBar: const OrdenList(),
    );
  }
}

class TabBody extends StatelessWidget {
  const TabBody({
    super.key,
    required this.productProvider,
    required this.id,
  });

  final ProductsProvider productProvider;
  final String id;

  @override
  Widget build(BuildContext context) {
    final products = productProvider.productsCategory;
    return RefreshIndicator(
      onRefresh: () => productProvider.getAllByCategory(id),
      child: Expanded(
        child: productProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : productProvider.hasError
                ? const ErrorMessage()
                : Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ListView.builder(
                      itemCount: products?.length,
                      itemBuilder: (context, index) => ProductsCard(
                        product: products![index],
                      ),
                    ),
                  ),
      ),
    );
  }
}

/**
 * Ejemplo de la paginacion
 * 
bool _isLoadingNextPage = false;

@override
Widget build(BuildContext context) {
  return ListView.builder(
    controller: _scrollController,
    itemCount: itemsList.length + 1, // Agregar un elemento adicional para mostrar el indicador de progreso circular
    itemBuilder: (BuildContext context, int index) {
      // Verificar si el índice es igual al número de elementos en la lista, lo que indica que se debe mostrar el indicador de progreso circular
      if (index == itemsList.length) {
        // Verificar si se está cargando la siguiente página, en cuyo caso se muestra el indicador de progreso circular
        if (_isLoadingNextPage) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SizedBox.shrink(); // Ocultar la vista del indicador de progreso circular
        }
      } else {
        // Renderizar los elementos de la lista
        return ListTile(
          title: Text(itemsList[index]['title']),
          subtitle: Text(itemsList[index]['subtitle']),
        );
      }
    },  
  );
}

void _fetchNextPage(String nextPageUrl) async {
  // Establecer _isLoadingNextPage a true para mostrar el indicador de progreso circular
  setState(() {
    _isLoadingNextPage = true;
  });

  // Realizar la solicitud a la API con la página siguiente
  final response = await http.get(nextPageUrl);

  // Verificar si la solicitud fue exitosa
  if (response.statusCode == 200) {
    // Obtener los datos de la respuesta
    final jsonData = jsonDecode(response.body);

    // Actualizar la lista actual con los nuevos elementos
    setState(() {
      itemsList.addAll(jsonData['items']);
    });

    // Actualizar el objeto de proveedor con los nuevos datos
    setState(() {
      providerData = {
        'limit': jsonData['limit'],
        'currentPage': jsonData['currentPage'],
        'nextPage': jsonData['nextPage'],
        'prevPage': jsonData['prevPage'],
        'next': jsonData['next'],
        'prev': jsonData['prev'],
        'totalPages': jsonData['totalPages']
      };
    });
  } else {
    throw Exception('Failed to fetch data');
  }

  // Establecer _isLoadingNextPage a false para ocultar el indicador de progreso circular
  setState(() {
    _isLoadingNextPage = false;
  });
}

 * 
 */
