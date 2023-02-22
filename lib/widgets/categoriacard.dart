import 'package:flutter/material.dart';

class Categoria extends StatelessWidget {
  final String nameCategoria;
  final String routeName;
  final String urlImg;

  const Categoria({
    Key? key,
    required this.nameCategoria,
    required this.routeName,
    required this.urlImg,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Material(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Container(
            width: 127.0,
            height: 105.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0.0,
                  top: 56.0,
                  right: null,
                  bottom: null,
                  width: 127.0,
                  height: 49.0,
                  child: SizedBox(
                    width: 10,
                    height: 49,
                    child: Card(
                      color: const Color.fromRGBO(186, 0, 0, 1),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(0.0),
                          bottomLeft: Radius.circular(0.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          Text(
                            nameCategoria,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 23.0,
                  top: 0.0,
                  right: null,
                  bottom: null,
                  width: 80.0,
                  height: 80.0,
                  child: SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          image: DecorationImage(
                            // image: NetworkImage(urlImg),
                            image: FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.gif',
                              image: urlImg,
                              fit: BoxFit.cover,
                            ).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
