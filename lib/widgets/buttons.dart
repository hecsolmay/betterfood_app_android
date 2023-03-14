import 'package:betterfood_app_android/utils/custom_delegate.dart';
import 'package:flutter/material.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const Dialog(
            child: Text("Hola"),
          ),
        );
      },
      icon: const Icon(Icons.help),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomDelegate(),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
