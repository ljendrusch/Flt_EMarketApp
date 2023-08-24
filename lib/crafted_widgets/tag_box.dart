import 'package:inventory_plus/global_h.dart';

class TagBox extends StatelessWidget {
  final Tag tag;

  const TagBox({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      fillColor: Theme.of(context).colorScheme.tertiaryContainer,
      splashColor: Theme.of(context).splashColor,
      elevation: 2,
      onPressed: () =>
          Navigator.of(context).pushNamed(tagDetailRoute, arguments: tag),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (tag.imageItem != null)
            Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(image: tag.decorationImage())),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surface.withAlpha(140)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tag.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text('${tag.items.length} Items',
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
