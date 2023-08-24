import 'package:inventory_plus/global_h.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  String _searchKey = '';
  // List<Item> items = [];
  // List<Item> results = [];

  @override
  void initState() {
    _searchKey = '';
    searchController
        .addListener(() => setState(() => _searchKey = searchController.text));
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<Items>(context).items;
    List<Item> results = [];

    if (!_searchKey.isWhitespace()) {
      results = items
          .where((item) =>
              item.name.startsWith(RegExp(_searchKey, caseSensitive: false)))
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .12),
          child: Form(
            key: _formKey,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: searchController,
              decoration: const InputDecoration(
                constraints: BoxConstraints.tightFor(height: 44),
                contentPadding: EdgeInsets.zero,
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        (_searchKey == '')
            ? Text(
                'Enter keyword to search',
                style: Theme.of(context).textTheme.headlineSmall,
              )
            : (items.isEmpty)
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Couldn't find anything for\n",
                      style: Theme.of(context).textTheme.headlineSmall,
                      children: [
                        TextSpan(
                          text: _searchKey,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ItemList(items: results),
                  ),
      ],
    );
  }
}
