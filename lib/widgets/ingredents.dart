import 'package:betterfood_app_android/dtos/providers/customprovider.dart';
import 'package:betterfood_app_android/dtos/response/productdetailresponse.dart';
import 'package:flutter/material.dart';
import 'package:betterfood_app_android/common/common.dart';
import 'package:provider/provider.dart';

class ListRemoveIngredents extends StatelessWidget {
  const ListRemoveIngredents({
    super.key,
    required this.removeIngredents,
  });

  final Iterable<Ingredent> removeIngredents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        BigText(
          text: "Ingredientes que se pueden quitar",
          size: 15,
        ),
        const SizedBox(height: 20),
        ...removeIngredents
            .map((e) => RemoveIngredent(id: e.id, name: e.name))
            .toList(),
      ],
    );
  }
}

class RemoveIngredent extends StatelessWidget {
  final String id;
  final String name;
  const RemoveIngredent({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final ingredentProvider = Provider.of<CustomIngredentsProvider>(context);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        ingredentProvider.addRemove(id);
      },
      background: Container(
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListExtraIngredents extends StatelessWidget {
  const ListExtraIngredents({
    super.key,
    required this.extraIngredents,
  });

  final Iterable<Ingredent> extraIngredents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        BigText(
          text: "Ingredientes Extra",
          size: 15,
        ),
        const SizedBox(height: 10),
        ...extraIngredents.map((e) {
          return ExtraIngredent(
            id: e.id,
            name: e.name,
            extraPrice: e.extraPrice,
          );
        }).toList(),
      ],
    );
  }
}

class ExtraIngredent extends StatelessWidget {
  final String name;
  final int extraPrice;
  final String id;
  const ExtraIngredent({
    super.key,
    required this.name,
    required this.id,
    required this.extraPrice,
  });

  @override
  Widget build(BuildContext context) {
    final ingredentsProvider = Provider.of<CustomIngredentsProvider>(context);
    final found = ingredentsProvider.extrasContains(id);
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                found ? '1' : '0',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 15),
              Text('\$${extraPrice.toStringAsFixed(2)}'),
              const SizedBox(width: 16),
              found
                  ? IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline_rounded,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        ingredentsProvider.removeExtra(id);
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.add_box_rounded,
                        color: Colors.black,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        ingredentsProvider.addExtra(id);
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class IngredentsList extends StatelessWidget {
  const IngredentsList({
    super.key,
    required this.ingredents,
    required this.text,
  });

  final Iterable<Ingredent>? ingredents;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        BigText(
          text: text,
          size: 15,
        ),
        const SizedBox(height: 10),
        ...ingredents?.map((e) => UnorderedListItem(text: e.name)).toList() ??
            [],
      ],
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  final String text;
  const UnorderedListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "• ",
            style: TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
