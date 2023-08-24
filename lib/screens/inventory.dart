import 'package:inventory_plus/global_h.dart';

class Inventory extends StatefulWidget {
  final dynamic args;

  const Inventory({super.key, this.args});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  late int activeTabIndex;
  // List<Item> _items = [];
  // List<Tag> _tags = [];

  @override
  void initState() {
    activeTabIndex =
        (widget.args != null && widget.args[ArgType.inventoryTabIndex] != null)
            ? widget.args[ArgType.inventoryTabIndex]
            : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> _items = Provider.of<Items>(context).items;
    List<Tag> _tags = Provider.of<Tags>(context).tags;

    List<bool> isSelected = [activeTabIndex == 0, activeTabIndex == 1];

    return Stack(
      children: [
        [
          _ItemsList(items: _items),
          _TagsList(tags: _tags),
        ][activeTabIndex],
        Align(
          alignment: Alignment.topCenter,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).backgroundColor.withAlpha(140),
            child: ToggleButtons(
              constraints: BoxConstraints.tight(Size(screenWidth * .4, 36)),
              onPressed: (_) =>
                  setState(() => activeTabIndex = (activeTabIndex + 1) % 2),
              isSelected: isSelected,
              children: [
                Text('${_items.length} Items',
                    style: const TextStyle(fontSize: 16)),
                Text('${_tags.length} Tags',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemsList extends StatefulWidget {
  final List<Item> items;

  const _ItemsList({required this.items});

  @override
  State<_ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<_ItemsList> {
  // late int activeTypeIndex;

  @override
  Widget build(BuildContext context) {
    int activeTypeIndex =
        (Provider.of<LocalSettings>(context).itemsViewType == ViewMode.list)
            ? 0
            : 1;

    List<bool> isSelected = [activeTypeIndex == 0, activeTypeIndex == 1];

    return Stack(
      children: [
        (activeTypeIndex == 0)
            ? ListView.separated(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(top: 144),
                itemCount: widget.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  Item item = widget.items[index];

                  return ItemTile(item: item);
                },
              )
            : GridView.builder(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 144, 24, 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  Item item = widget.items[index];

                  return ItemBox(item: item);
                },
              ),
        Align(
          alignment: const Alignment(.8, .9),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).backgroundColor.withAlpha(140),
            child: ToggleButtons(
              constraints: BoxConstraints.tight(const Size(64, 32)),
              onPressed: (_) => setState(() {
                activeTypeIndex = (activeTypeIndex + 1) % 2;
                Provider.of<LocalSettings>(context, listen: false)
                    .setItemsViewType(
                        (activeTypeIndex == 0) ? ViewMode.list : ViewMode.grid);
              }),
              isSelected: isSelected,
              children: const [
                Icon(Icons.view_headline),
                Icon(Icons.grid_view)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TagsList extends StatefulWidget {
  final List<Tag> tags;

  const _TagsList({required this.tags});

  @override
  State<_TagsList> createState() => _TagsListState();
}

class _TagsListState extends State<_TagsList> {
  @override
  Widget build(BuildContext context) {
    int activeTypeIndex =
        (Provider.of<LocalSettings>(context, listen: false).tagsViewType ==
                ViewMode.list)
            ? 0
            : 1;
    List<bool> isSelected = [activeTypeIndex == 0, activeTypeIndex == 1];

    return Stack(
      children: [
        (activeTypeIndex == 0)
            ? ListView.separated(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(top: 144),
                itemCount: widget.tags.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  Tag tag = widget.tags[index];

                  return TagTile(tag: tag);
                },
              )
            : GridView.builder(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 144, 24, 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.tags.length,
                itemBuilder: (_, index) {
                  Tag tag = widget.tags[index];

                  return TagBox(tag: tag);
                },
              ),
        Align(
          alignment: const Alignment(.8, .9),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).backgroundColor.withAlpha(140),
            child: ToggleButtons(
              constraints: BoxConstraints.tight(const Size(64, 32)),
              onPressed: (_) => setState(() {
                activeTypeIndex = (activeTypeIndex + 1) % 2;
                Provider.of<LocalSettings>(context, listen: false)
                    .setTagsViewType(
                        (activeTypeIndex == 0) ? ViewMode.list : ViewMode.grid);
              }),
              isSelected: isSelected,
              children: const [
                Icon(Icons.view_headline),
                Icon(Icons.grid_view)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
