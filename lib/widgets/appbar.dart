import 'package:flutter/material.dart';

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({super.key});

  @override
  onSearch(String search) {
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: TextField(
        onChanged: (value) => onSearch(value),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: const Icon(
              Icons.search,
              color: Color.fromRGBO(186, 0, 0, 1),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color.fromRGBO(186, 0, 0, 1),
            ),
            hintText: "Buscar"),
      ),
    );
  }
}
