import 'package:inventory_plus/global_h.dart';

class TagForm extends StatelessWidget {
  final dynamic args;

  const TagForm({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: TagFormBody(args: args),
    );
  }

  void showDeleteDialog(BuildContext context, Tag tag) {
    final Widget yesButton = TextButton(
      child: const Text('Yes'),
      onPressed: () => Provider.of<Tags>(context, listen: false)
          .removeTag(tag)
          .then((removed) => (removed)
              ? {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Tag deleted successfully'))),
                  Navigator.of(context).pushNamed(tagDetailRoute)
                }
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Unable to delete tag')))),
    );

    final Widget noButton = TextButton(
      child: const Text('No'),
      onPressed: () => Navigator.of(context).pop(false),
    );

    // set up the Delete popup
    final AlertDialog alert = AlertDialog(
      title: const Text('Notice'),
      content: Text('Are you sure you want to delete tag ${tag.name}?'),
      actions: [yesButton, noButton],
    );

    showDialog(
      context: context,
      builder: (_) => alert,
    );
  }
}

class TagFormBody extends StatefulWidget {
  final dynamic args;

  const TagFormBody({super.key, this.args});

  @override
  State<TagFormBody> createState() => _TagFormBodyState();
}

class _TagFormBodyState extends State<TagFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final Tag _tag;
  Item? _item;

  @override
  void initState() {
    _tag = (widget.args != null && widget.args[ArgType.tag] != null)
        ? widget.args[ArgType.tag]
        : Tag();
    _item = (widget.args != null && widget.args[ArgType.item] != null)
        ? widget.args[ArgType.item]
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Make a Tag',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            TextFormField(
              initialValue: _tag.name,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                labelText: 'Name',
                labelStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              validator: (value) =>
                  (value == null || value.isWhitespace()) ? '' : null,
              onSaved: (value) {
                _tag.name = value ?? '';
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              initialValue: _tag.description,
              maxLines: 2,
              minLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                labelText: 'Description',
                labelStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              onSaved: (value) {
                _tag.description = value ?? '';
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text('Save', style: TextStyle(fontSize: 18))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  if (_tag.id == null || _tag.id == '') {
                    Provider.of<Tags>(context, listen: false).addTag(_tag).then(
                        (tagAdded) => (tagAdded)
                            ? _redirect(_tag)
                            : _toast('Error adding tag'));
                  } else {
                    Provider.of<Tags>(context, listen: false)
                        .updateTag(_tag)
                        .then((tagUpdated) => (tagUpdated)
                            ? _redirect(_tag)
                            : _toast('Error adding tag'));
                  }
                } else {
                  _toast('Error parsing text entered');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _redirect(Tag newTag) {
    // if item is passed as args, we send it to item form
    // else, we route to detail page of the freshly made Tag
    if (_item != null) {
      _item!.tags.add(_tag);

      Navigator.of(context).pushNamed(itemFormRoute, arguments: _item);
    } else {
      Navigator.of(context).pushNamed(tagDetailRoute, arguments: newTag);
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
