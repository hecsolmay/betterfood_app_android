import 'package:betterfood_app_android/pages/screens.dart';
import 'package:flutter/material.dart';

class Categoria extends StatelessWidget {
  final String nameCategoria;
  final String urlImg;
  final int index;
  const Categoria({
    Key? key,
    required this.nameCategoria,
    required this.urlImg,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Categories(index: index + 1),
        ),
      )
      // Navigator.pushNamed(context, '/categories', arguments: {id});
      ,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: urlImg,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 38,
              width: MediaQuery.of(context).size.width / 2.2,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(172, 13, 14, 13)),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  nameCategoria,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 233, 233, 233),
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// class Categoria extends StatelessWidget {
//   final String nameCategoria;
//   final String routeName;
//   final String urlImg;

//   const Categoria({
//     Key? key,
//     required this.nameCategoria,
//     required this.routeName,
//     required this.urlImg,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const BorderRadius border = BorderRadius.only(
//       topLeft: Radius.circular(90),
//       topRight: Radius.circular(90),
//       // bottomLeft: Radius.circular(90),
//     );
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(context, routeName);
//       },
//       child: Column(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: border,
//                   image: DecorationImage(
//                     image: FadeInImage.assetNetwork(
//                       placeholder: 'assets/loading.gif',
//                       image: urlImg,
//                       fit: BoxFit.cover,
//                     ).image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 color: Color.fromARGB(255, 223, 9, 9),
//               ),
//               child: Center(
//                 child: Text(
//                   "$nameCategoria asmkasvakslmksa",
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ), //custom text and style
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
