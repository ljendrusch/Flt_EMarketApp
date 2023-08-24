import 'package:inventory_plus/global_h.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 24, right: 24),
      child: ListView(
        physics: const ScrollPhysics(),
        children: [
          _ItemsBlock(),
          SizedBox(height: 16),
          _TagsBlockTitle(),
          SizedBox(height: 8),
          _TagsBlock(),
          SizedBox(height: 16),
          _RecentsBlockTitle(),
          SizedBox(height: 8),
          _RecentsBlock(),
        ],
      ),
    );
  }
}

const double _diagonalAngle = pi / 15;
final double _dataBoxDim = screenWidth * 0.22;
final double _dataRowHeight = 2 * 8 + _dataBoxDim;
final double _spaceWidth = tan(_diagonalAngle) * _dataRowHeight;
const double _sliceWidth = 6;
const double _horizPaddingOffset = 44;
final double _alphaBoxWidthOffset =
    _spaceWidth / 2 - _sliceWidth / cos(_diagonalAngle);
final double _alphaBoxWidth =
    ((screenWidth / 2) - _horizPaddingOffset) + _alphaBoxWidthOffset;

class _ItemsBlock extends StatelessWidget {
  const _ItemsBlock();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context).user;

    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      shadowColor: Theme.of(context).shadowColor,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.tertiaryContainer,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ButtonWrapper(
          splashColor: Theme.of(context).splashColor,
          onPressed: () => HomeScaffold.of(context)!.moveToTab(1),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ClipPath(
                  clipper: _ClipRRectDiagonalRight(),
                  child: Material(
                    color: Theme.of(context).backgroundColor.withAlpha(140),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: _alphaBoxWidth),
                      child: Padding(
                        padding: EdgeInsets.only(right: _spaceWidth),
                        child: SizedBox(
                          width: _dataBoxDim,
                          height: _dataBoxDim,
                          child: Align(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '${user.itemsCount}\n',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                  TextSpan(
                                      text: 'Items',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ClipPath(
                  clipper: _ClipRRectDiagonalLeft(),
                  child: Material(
                    color: Theme.of(context).backgroundColor.withAlpha(140),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: _alphaBoxWidth),
                      child: Padding(
                        padding: EdgeInsets.only(left: _spaceWidth),
                        child: SizedBox(
                          width: _dataBoxDim,
                          height: _dataBoxDim,
                          child: Align(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '\$${user.totalValue.round()}\n',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                  TextSpan(
                                      text: 'Value',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagsBlockTitle extends StatelessWidget {
  const _TagsBlockTitle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(-0.8, 0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
          child: Text('Sorted by Tags',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _TagsBlock extends StatelessWidget {
  const _TagsBlock();

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = Provider.of<Tags>(context).tags;

    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      shadowColor: Theme.of(context).shadowColor,
      child: Container(
        height: _dataRowHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.tertiaryContainer,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: (tags.isEmpty)
            ? Material(
                type: MaterialType.card,
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surface.withAlpha(140),
                child: Center(
                  child: Text('No Tag Data',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).hintColor)),
                ),
              )
            : Center(
                child: ListView.separated(
                  primary: false,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: tags.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    Tag tag = tags[index];
                    // tag.imageItem = ImageItem(type: ImageType.url, value: '');

                    return ButtonWrapper(
                      splashColor: Theme.of(context).splashColor,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(tagDetailRoute, arguments: tag),
                      child: Container(
                        decoration: (tag.imageItem != null)
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .backgroundColor
                                    .withAlpha(140),
                                image: tag.decorationImage(),
                              )
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .backgroundColor
                                    .withAlpha(180),
                              ),
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        width: _dataBoxDim,
                        height: _dataBoxDim,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: (tag.imageItem != null)
                                ? BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface
                                        .withAlpha(140),
                                    borderRadius: BorderRadius.circular(8))
                                : null,
                            child: Text(
                              tag.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class _RecentsBlockTitle extends StatelessWidget {
  const _RecentsBlockTitle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(-0.8, 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
          child: Text('Recent Items',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _RecentsBlock extends StatelessWidget {
  const _RecentsBlock();

  @override
  Widget build(BuildContext context) {
    List<Item> recentItems = Provider.of<Items>(context).items;
    if (recentItems.isEmpty) {
      print('empty items provider');
    } else {
      recentItems.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    }
    if (recentItems.length > 10) {
      recentItems = recentItems.sublist(0, 10);
    }

    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.tertiaryContainer,
            Theme.of(context).colorScheme.tertiary,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: (recentItems.isEmpty)
          ? Material(
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.surface.withAlpha(140),
              child: SizedBox(
                height: _dataBoxDim,
                child: Center(
                  child: Text('No Item Data',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Theme.of(context).hintColor)),
                ),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                Item item = recentItems[index];

                return ButtonWrapper(
                  splashColor: Theme.of(context).splashColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(itemDetailRoute, arguments: item),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          image: item.decorationImage(),
                        ),
                        clipBehavior: Clip.hardEdge,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 4),
                            Align(
                              child: Text(
                                '\$${item.value.round().toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date Added: ${DateFormat('M-d-y').format(DateTime.parse(item.createdDate))}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _ClipRRectDiagonalLeft extends CustomClipper<Path> {
  final double _roundedCornerRadius = 8;

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(_spaceWidth, 0);
    path.lineTo(0, h);
    path.lineTo(w - _roundedCornerRadius, h);
    path.quadraticBezierTo(w, h, w, h - _roundedCornerRadius);
    path.lineTo(w, _roundedCornerRadius);
    path.quadraticBezierTo(w, 0, w - _roundedCornerRadius, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _ClipRRectDiagonalRight extends CustomClipper<Path> {
  final double _roundedCornerRadius = 8;

  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(w, 0);
    path.lineTo(w - _spaceWidth, h);
    path.lineTo(_roundedCornerRadius, h);
    path.quadraticBezierTo(0, h, 0, h - _roundedCornerRadius);
    path.lineTo(0, _roundedCornerRadius);
    path.quadraticBezierTo(0, 0, _roundedCornerRadius, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
