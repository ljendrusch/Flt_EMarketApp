import 'package:inventory_plus/global_h.dart';

class TagDetails extends StatefulWidget {
  final Tag tag;

  const TagDetails({super.key, required this.tag});

  @override
  State<TagDetails> createState() => _TagDetailsState();
}

class _TagDetailsState extends State<TagDetails> {
  late Tag _tag;

  @override
  void initState() {
    _tag = widget.tag;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tag Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (index) => (index == 0)
                ? Navigator.of(context)
                    .pushNamed(tagFormRoute, arguments: {ArgType.tag: _tag})
                : const TagForm().showDeleteDialog(context, _tag),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Edit'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * .2,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(image: _tag.decorationImage()),
          ),
          Container(
            height: 44,
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: screenWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        _tag.name,
                        style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context).colorScheme.onBackground),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                      width: 2,
                      height: 32,
                      color: Theme.of(context).colorScheme.onBackground),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      '${_tag.items.length} Items',
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: screenHeight -
                      AppBar().preferredSize.height -
                      MediaQuery.of(context).viewPadding.top -
                      MediaQuery.of(context).viewPadding.bottom -
                      (screenHeight * .2) -
                      44),
              //      screen height - appbar height - device top bar - device bottom bar - picture height - tag title bar
              child: ItemList(items: _tag.items)),
        ],
      ),
    );
  }
}
