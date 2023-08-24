import 'package:inventory_plus/global_h.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetails extends StatefulWidget {
  final Item item;

  const ItemDetails({super.key, required this.item});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  List<ItemRecommendation> recommendationsList = [];

  @override
  void initState() {
    Provider.of<Recommendations>(context, listen: false)
        .fetchRecommendedItems(widget.item.upc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    recommendationsList = Provider.of<Recommendations>(context).items;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Item Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _ItemBanner(item: widget.item),
                _ItemDetail(item: widget.item),
              ],
            ),
          ),
          if (recommendationsList.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Inspired by your inventory',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          if (recommendationsList.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              sliver:
                  _ItemRecommendationList(recommendations: recommendationsList),
            ),
        ],
      ),
    );
  }
}

class _ItemBanner extends StatelessWidget {
  final Item item;

  const _ItemBanner({required this.item});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      children: (item.images.isNotEmpty)
          ? item.images
              .map((_) => FittedBox(fit: BoxFit.fitWidth, child: item.image))
              .toList()
          : [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
                child: Image.asset('assets/logo.png'),
              ),
            ],
    );
  }
}

class _ItemDetail extends StatelessWidget {
  final Item item;

  const _ItemDetail({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 15),
          Text(
            'Added: ${DateFormat('M-d-y').format(DateTime.parse(item.createdDate))}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (item.value != 0.0) ...[
            const Divider(height: 28, thickness: 1),
            Text(
              'Value',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 5),
            Text(
              '\$${item.value.round()}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
          if (item.tags.isNotEmpty) ...[
            const Divider(height: 28, thickness: 1),
            Text(
              (item.tags.length > 1) ? 'Tags' : 'Tag',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 5),
            ...item.tags
                .sublist(0, item.tags.length - 1)
                .map((e) => Text('${e.name}, ',
                    style: Theme.of(context).textTheme.labelLarge))
                .toList(),
            Text(item.tags.last.name,
                style: Theme.of(context).textTheme.labelLarge),
          ],
          if (item.fields.isNotEmpty)
            ...item.fields
                .expand((field) => [
                      const Divider(height: 28, thickness: 1),
                      Text(
                        field.name.capitalize(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 5),
                      (field.type == FieldType.color)
                          ? Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(int.parse(field.value))
                                      .withOpacity(1),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface)))
                          : (field.type == FieldType.date)
                              ? Text(
                                  DateFormat('M-d-y')
                                      .format(DateTime.parse(field.value)),
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : Text(field.value,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                    ])
                .toList(),
        ],
      ),
    );
  }
}

class _ItemRecommendationList extends StatelessWidget {
  final List<ItemRecommendation> recommendations;

  const _ItemRecommendationList({required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _RecommedationItemCard(recommendation: recommendations[index]);
        },
        childCount: recommendations.length,
      ),
    );
  }
}

class _RecommedationItemCard extends StatelessWidget {
  final ItemRecommendation recommendation;

  const _RecommedationItemCard({required this.recommendation});

  Future<void> _launchURL(String url) async {
    url = Uri.encodeFull(url);
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          recommendation.affiliateLink.isNotEmpty
              ? _launchURL(recommendation.affiliateLink)
              : const Text('Could not launch url');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    child: Image(
                      height: 117,
                      image: recommendation.imageProvider,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            _RecommendationItemCardInfo(recommendation: recommendation),
          ],
        ),
      ),
    );
  }
}

class _RecommendationItemCardInfo extends StatelessWidget {
  final ItemRecommendation recommendation;

  const _RecommendationItemCardInfo({required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recommendation.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 5),
          Text(
            '\$${recommendation.value}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
