import 'package:inventory_plus/global_h.dart';

class ItemBox extends StatelessWidget {
  final Item item;

  const ItemBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      fillColor: Theme.of(context).colorScheme.tertiaryContainer,
      splashColor: Theme.of(context).splashColor,
      elevation: 2,
      onPressed: () =>
          Navigator.of(context).pushNamed(itemDetailRoute, arguments: item),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(image: item.decorationImage()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withAlpha(140),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                child: Text('\$${item.value.round()}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onBackground)),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.surface.withAlpha(140),
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Text(item.name,
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onBackground),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
