import 'package:inventory_plus/global_h.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Users>(context).user;
    List<Item> items = Provider.of<Items>(context).items;
    List<Item> publicItems =
        (items.isNotEmpty) ? items.where((item) => item.isPublic).toList() : [];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Profile',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold))),
      body: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            height: screenHeight -
                AppBar().preferredSize.height -
                MediaQuery.of(context).viewPadding.top -
                MediaQuery.of(context)
                    .viewPadding
                    .bottom), // safe area calculation
        child: Column(
          children: [
            _profileInfo(context, user),
            const SizedBox(height: 12),
            _pinsButton(context),
            const SizedBox(height: 12),
            Expanded(child: ItemList(items: publicItems)),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context, User user) {
    String email = (user.email.length > 20)
        ? user.email.replaceFirst(RegExp(r'@'), '@\n')
        : user.email;

    return Material(
      elevation: 2,
      shadowColor: Theme.of(context).shadowColor,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: screenWidth * 0.3,
                width: screenWidth * 0.3,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, image: user.decorationImage())),
            Text(
              '${user.name}\n${user.location}\n\n$email',
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget _pinsButton(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 194),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.push_pin_rounded, size: 18),
        label: const Text('Customize your Pins'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return const ProfilePinItemForm();
            },
          );
        },
      ),
    );
  }
}

class ProfilePinItemForm extends StatefulWidget {
  const ProfilePinItemForm({super.key});

  @override
  State<ProfilePinItemForm> createState() => _ProfilePinItemFormState();
}

class _ProfilePinItemFormState extends State<ProfilePinItemForm> {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<Items>(context).items;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        Item item = items[index];

        return ButtonWrapper(
          splashColor: Theme.of(context).splashColor,
          onPressed: () {
            item.isPublic = !item.isPublic;
            Provider.of<Items>(context, listen: false).updateItem(item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: (item.isPublic)
                    ? Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : const Border(),
              ),
              child: Row(
                children: [
                  Expanded(child: SizedBox(height: 80, child: item.image)),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat.yMd().add_jm().format(
                                  DateTime.parse(
                                    item.createdDate,
                                  ),
                                ),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
