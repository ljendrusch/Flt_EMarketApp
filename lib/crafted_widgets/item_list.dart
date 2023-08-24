import 'package:inventory_plus/global_h.dart';

class ItemList extends StatelessWidget {
  final List<Item> items;

  const ItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 18),
      physics: const ScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        Item item = items[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ItemTile(item: item),
        );
      },
    );
  }
}
