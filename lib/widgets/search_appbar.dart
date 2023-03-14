import 'dart:convert';

import 'package:betterfood_app_android/widgets/notfoundscree.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AppBarSearch extends StatefulWidget {
  const AppBarSearch({super.key});

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  List<dynamic> _results = [];

  Future<void> _onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        _isSearching = false;
        _results.clear();

        _searchController.text = text;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final url = Uri.parse(
        'https://betterfood-api.up.railway.app/api/m/product/?q=$text');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'] as List<dynamic>;

      setState(() {
        _results = data;
      });

      if (_results.isEmpty) {}
    } else {
      setState(() {
        _results.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(
            width: 340,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                contentPadding: const EdgeInsets.all(0),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(186, 0, 0, 1),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(186, 0, 0, 1),
                ),
                hintText: 'Buscar...',
              ),
              onChanged: _onSearchTextChanged,
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
          if (_isSearching)
            SizedBox(
              height: 715,
              child: SingleChildScrollView(
                child: _isSearching
                    ? _results.isEmpty
                        ? const NotFoundScreen()
                        : ListView.builder(
                            shrinkWrap: true, // Agregado
                            itemCount: _results.length,
                            itemBuilder: (context, index) {
                              final item = _results[index];
                              return ListTile(
                                title: Text(item['name'] as String),
                                subtitle: Text(item['description'] as String),
                                trailing: Text('\$${item['price']}'),
                              );
                            },
                          )
                    : const SizedBox.shrink(),
              ),
            ),
        ],
      ),
    );
  }
}
