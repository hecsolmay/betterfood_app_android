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
    const BorderRadius border = BorderRadius.only(
      topLeft: Radius.circular(90),
      topRight: Radius.circular(90),
      // bottomLeft: Radius.circular(90),
    );
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: border),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: border,
                  image: DecorationImage(
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
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 223, 9, 9),
                ),
                child: Center(
                  child: Text(
                    "$nameCategoria asmkasvakslmksa",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ), //custom text and style
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*

Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 80,
                  child: SizedBox(
                    width: 127.0,
                    height: 56.0,
                    child: Card(
                      color: const Color.fromRGBO(186, 0, 0, 1),
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
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
                  top: 18,
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

*/
