import 'package:inventory_plus/global_h.dart';

class ScanHandler extends StatefulWidget {
  final dynamic args;

  const ScanHandler({super.key, this.args});

  @override
  State<ScanHandler> createState() => _ScanHandlerState();
}

class _ScanHandlerState extends State<ScanHandler> {
  BarcodeScanResult? barcodeRecommendItem;
  String scannedCode = '';
  Item currentItem = Item();
  String source = 'none';
  bool inProgress = true;

  @override
  void initState() {
    List<Item> items = Provider.of<Items>(context, listen: false).items;

    if (widget.args != null) {
      scannedCode = widget.args as String;
      setState(() {
        currentItem = Item(
          upc: scannedCode,
          createdDate: DateTime.now().toString(),
        );
      });

      final Item? inMemoryItem =
          items.firstWhere((item) => item.upc == scannedCode);
      if (inMemoryItem != null) {
        setState(() {
          currentItem = inMemoryItem;
          source = 'in_memory';
          inProgress = false;
        });
        return;
      }

      // Fetching the item from `/upc/{upcId}`
      final Future<BarcodeScanResult?> response =
          Provider.of<Items>(context, listen: false)
              .getBarcodeRecommendation(scannedCode);

      response.then((item) => {
            if (item != null)
              {
                setState(() {
                  barcodeRecommendItem = item;
                  currentItem = Item(
                    name: barcodeRecommendItem!.name,
                    images: barcodeRecommendItem!.images,
                    value: barcodeRecommendItem!.value,
                    upc: barcodeRecommendItem!.barcode,
                    createdDate: DateTime.now().toString(),
                  );
                  source = 'recommended';
                  inProgress = false;
                })
              }
            else
              {
                setState(() {
                  inProgress = false;
                })
              }
          });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget? body;

    // Fetch existing item
    if (source == 'in_memory') {
      // item is not null, found item
      body = InventoryItem(item: currentItem).build(context);
    } else if (source == 'recommended') {
      // recommendation is not null, found recommendation
      body = RecommendedItemScreen(item: currentItem).build(context);
    } else {
      // nothing found, we create from scratch
      body = NewInventoryItem(item: currentItem).build(context);
    }

    if (inProgress) {
      body = Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Text(
            'Loading...',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: body,
    );
  }
}

class InventoryItem extends StatelessWidget {
  final Item item;

  const InventoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            'From Your Inventory',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        ItemTile(item: item),
      ],
    );
  }
}

class RecommendedItemScreen extends StatelessWidget {
  final Item item;

  const RecommendedItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Text(
            'Recommended Item',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          padding: const EdgeInsets.all(5),
          child: ItemTile(item: item, height: 120),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(homeRoute),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(itemFormRoute, arguments: item),
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }
}

class NewInventoryItem extends StatelessWidget {
  final Item item;

  const NewInventoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!item.upc.isWhitespace()) ...[
            Text('No matching result found',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
          ],
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              itemFormRoute,
              arguments: item,
            ),
            child: const Text('Add a new item'),
          )
        ],
      ),
    );
  }
}
