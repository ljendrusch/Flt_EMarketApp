import 'package:inventory_plus/global_h.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final double height;

  const ItemTile({super.key, required this.item, this.height = 132});

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      fillColor: Theme.of(context).colorScheme.surface,
      splashColor: Theme.of(context).splashColor,
      elevation: 2,
      isRounded: false,
      onPressed: () =>
          Navigator.of(context).pushNamed(itemDetailRoute, arguments: item),
      child: Row(
        children: [
          SizedBox(
            width: height,
            height: height,
            child: (item.images.isNotEmpty)
                ? FittedBox(
                    fit: BoxFit.cover,
                    alignment: const Alignment(-.5, 0),
                    clipBehavior: Clip.hardEdge,
                    child: item.image)
                : null,
          ),
          Expanded(
            child: SizedBox(
              height: height,
              child: Material(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 5),
                      Text('\$${item.value.round()}'),
                      const SizedBox(height: 5),
                      Text(DateFormat.yMd()
                          .add_jm()
                          .format(DateTime.parse(item.createdDate))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
