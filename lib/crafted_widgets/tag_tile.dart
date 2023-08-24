import 'package:inventory_plus/global_h.dart';

class TagTile extends StatelessWidget {
  final Tag tag;
  final double height;

  const TagTile({super.key, required this.tag, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      fillColor: Theme.of(context).colorScheme.surface,
      splashColor: Theme.of(context).splashColor,
      elevation: 2,
      isRounded: false,
      onPressed: () =>
          Navigator.of(context).pushNamed(tagDetailRoute, arguments: tag),
      child: Row(
        children: [
          if (tag.imageItem != null)
            SizedBox(
              width: height,
              height: height,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: const Alignment(-.5, 0),
                clipBehavior: Clip.hardEdge,
                child: tag.image,
              ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: (tag.imageItem != null)
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Text(tag.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      Text('${tag.items.length} Items',
                          style: Theme.of(context).textTheme.titleMedium),
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
