import 'package:flutter/material.dart';

class CustomDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    const loading = false;

    const data = [
      "Hola",
      "Hola",
      "Hola",
      "Hola",
      "Hola",
      "Hola",
      "Hola",
      "Hola",
      "Hola",
      "Hola",
    ];

    if (loading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Center(child: CircularProgressIndicator())],
      );
    } else if (data.length == 0) {
      return Column(
        children: const [Text("results Not found")],
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var element = data[index];
          return ListTile(
            title: Text(element),
          );
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Column();
  }
}
