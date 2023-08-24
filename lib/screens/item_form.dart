import 'package:inventory_plus/global_h.dart';
import 'package:image_picker/image_picker.dart';

class ItemForm extends StatelessWidget {
  final Item? item;

  const ItemForm({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text('Add an Item',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true),
      body: ItemFormBody(
        item: item ?? Item(createdDate: DateTime.now().toString()),
        tags: Provider.of<Tags>(context, listen: false).tags, //working?
      ),
    );
  }

  void showDeleteDialog(BuildContext context, Item item) {
    final Widget yesButton = TextButton(
      child: const Text('Yes'),
      onPressed: () => Provider.of<Items>(context, listen: false)
          .removeItem(item.id)
          .then((removed) => (removed)
              ? Navigator.of(context).pushNamed(homeRoute)
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Unable to delete the item')))),
    );

    final Widget noButton = TextButton(
      child: const Text('No'),
      onPressed: () => Navigator.of(context).pop(false),
    );

    final AlertDialog alert = AlertDialog(
      title: const Text('Notice'),
      content: Text('Are you sure you want to delete tag ${item.name}?'),
      actions: [yesButton, noButton],
    );

    showDialog(
      context: context,
      builder: (_) => alert,
    );
  }
}

class ItemFormBody extends StatefulWidget {
  final Item item;
  final List<Tag> tags;

  const ItemFormBody({super.key, required this.item, required this.tags});

  @override
  State<ItemFormBody> createState() => _ItemFormBody();
}

class _ItemFormBody extends State<ItemFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Item item;
  late List<Tag> tags;

  List<ImageItem> images = [];

  @override
  void initState() {
    item = widget.item;
    tags = widget.tags;
    images.addAll(item.images);
    super.initState();
  }

  Future<void> _getMultiImages() async {
    final ImagePicker multiPicker = ImagePicker();
    final List<XFile>? selectedImages = await multiPicker.pickMultiImage();

    final List<ImageItem> imgObjs = [];

    // In future this would be the URL of the
    for (final XFile selectedImage in selectedImages!) {
      imgObjs.add(ImageItem(
        type: ImageType.file,
        value: selectedImage.path,
      ));
    }
  }

  void _onSubmit(Item item) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (item.id.isWhitespace()) {
        Provider.of<Items>(context, listen: false)
            .addItem(item)
            .then((item) => _redirect(item, 'Error adding item'));
      } else {
        Provider.of<Items>(context, listen: false)
            .updateItem(item)
            .then((item) => _redirect(item, 'Error updating item'));
      }
    }
  }

  void _redirect(Item? item, String message) {
    if (item != null) {
      Navigator.of(context)
          .pushReplacementNamed(itemDetailRoute, arguments: item);
    } else {
      _toast(message);
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // load the custom fields in the item form
  List<Widget> _customFields(List<Field> fields) {
    final List<Widget> fieldWidgets = [];

    for (int index = 0; index < fields.length; index++) {
      final Field field = fields[index];
      Widget child = const Text('Invalid field');

      // generate a custom field
      if (field.type == FieldType.text) {
        child = TextFormFieldShortcut(
          labelText: field.name,
          initialValue: field.value,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter the ${field.name}';
            } else {
              return null;
            }
          },
          onSaved: (String? value) {
            fields[index].value = value ?? '';
          },
        );
      } else if (field.type == FieldType.color) {
        child = ColorFormFieldShortcut(field: field);
      } else if (field.type == FieldType.date) {
        child = DateFormFieldShortcut(
          labelText: field.name,
          initialValue: field.value,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter the ${field.name}';
            } else {
              return null;
            }
          },
          onSaved: (value) => fields[index].value = value ?? '',
        );
      } else if (field.type == FieldType.number) {
        child = TextFormFieldShortcut(
          initialValue: field.value == '0.0' ? '' : field.value,
          labelText: field.name,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
          ],
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'Please enter the ${field.name}';
            } else {
              return null;
            }
          },
          onSaved: (String? value) => {fields[index].value = value ?? ''},
        );
      }

      // append the actual field into the column
      fieldWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (field.type == FieldType.color)
              Text(field.name,
                  style: Theme.of(context).textTheme.headlineSmall),
            child,
            const SizedBox(height: 12),
          ],
        ),
      );
    }
    return fieldWidgets;
  }

  // trigger to open a custom field form when add button is hitted
  void _addField() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) =>
          _ItemCustomFieldForm(item: item, saveField: _saveField),
    );
  }

  // save a new field to the item
  void _saveField(Field field) {
    Navigator.of(context).pop();
    // reload the whole field list, maybe over-killed for this purpose
    setState(() => item.fields.add(field));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Images',
                          style: Theme.of(context).textTheme.headlineSmall)),
                  const SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        height: ((screenWidth - 48) * .25) - 6),
                    child: GridView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: (images.isEmpty) ? 4 : images.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return (index == 0)
                            ? ElevatedButton(
                                onPressed: () => _getMultiImages(),
                                child: Icon(
                                  Icons.add,
                                  size: 35,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              )
                            : (images.isEmpty)
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 2,
                                            color: Theme.of(context)
                                                .primaryColorLight)),
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 35,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  )
                                : item.image;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormFieldShortcut(
                    initialValue: item.name,
                    labelText: 'Name',
                    validator: (value) =>
                        (value == null || value.isWhitespace())
                            ? 'Item name required'
                            : null,
                    onSaved: (value) => item.name = value ?? '',
                  ),
                  const SizedBox(height: 12),
                  TextFormFieldShortcut(
                    initialValue:
                        (item.value == 0.0) ? '' : item.value.toString(),
                    labelText: 'Value',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    validator: (_) => null,
                    onSaved: (value) {
                      if (value == null || value.isEmpty) {
                        return;
                      }
                      item.value = double.parse(value);
                    },
                  ),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TagCheckboxDialog(item: item, allTags: tags),
                        OutlinedButton(
                          child: Row(
                            children: [
                              const Icon(Icons.add, size: 20),
                              const SizedBox(width: 6),
                              Text('Add Field', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                              alignment: Alignment.center,
                              fixedSize: Size(132, 46)),
                          onPressed: () => _addField(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (item.fields.isNotEmpty) ..._customFields(item.fields),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ButtonWrapper(
              fillColor: Theme.of(context).colorScheme.secondaryContainer,
              splashColor: Theme.of(context).splashColor,
              elevation: 2,
              onPressed: () => _onSubmit(item),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * .2, vertical: 8),
                child: const Text('Save',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemCustomFieldForm extends StatefulWidget {
  final Item item;
  final void Function(Field) saveField;

  const _ItemCustomFieldForm({required this.item, required this.saveField});

  @override
  State<_ItemCustomFieldForm> createState() => _ItemCustomFieldFormState();
}

class _ItemCustomFieldFormState extends State<_ItemCustomFieldForm> {
  final GlobalKey<FormState> _fieldFormKey = GlobalKey<FormState>();
  String _type = '';
  String _name = '';

  final List<DropdownMenuItem<String>> _customFieldTypeDropdownItems = const [
    DropdownMenuItem(value: 'text', child: Text('Text')),
    DropdownMenuItem(value: 'date', child: Text('Date')),
    DropdownMenuItem(value: 'number', child: Text('Number')),
  ];

  void _onSubmit(Item item) {
    if (_fieldFormKey.currentState!.validate()) {
      _fieldFormKey.currentState!.save();

      final Field field = Field();
      if (_type.isEmpty || _name.isEmpty) {
        return;
      }
      field.type = stringTypeMap[_type] ?? FieldType.text;
      field.name = _name;
      widget.saveField(field);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fieldFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Text(
              'Add a field',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Type',
                labelStyle: const TextStyle(fontSize: 15),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 15,
              ),
              validator: (value) => (value == null) ? 'Select a type' : null,
              onChanged: (value) {},
              onSaved: (value) => {
                if (value != null) {_type = value as String}
              },
              items: _customFieldTypeDropdownItems,
            ),
            const SizedBox(height: 20),
            TextFormFieldShortcut(
              labelText: 'Name',
              validator: (String? value) =>
                  value == null || value.isEmpty ? 'Enter a name' : null,
              onSaved: (String? value) => {
                if (value != null) {_name = value}
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.outline,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () => _onSubmit(widget.item),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TagCheckboxDialog extends StatelessWidget {
  final Item item;
  final List<Tag> allTags;

  const TagCheckboxDialog(
      {super.key, required this.item, required this.allTags});

  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      fillColor: Theme.of(context).colorScheme.tertiary,
      splashColor: Theme.of(context).splashColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        child: Text('Select Tags',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiary, fontSize: 16)),
      ),
      onPressed: (allTags.isEmpty)
          ? () {}
          : () async {
              var boolList = await showDialog<List<bool>>(
                context: context,
                builder: (context) {
                  List<bool> tagsChecked = allTags
                      .map((allTag) =>
                          item.tags.any((tag) => tag.id == allTag.id))
                      .toList();

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Dialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Available Tags',
                                    style: TextStyle(fontSize: 18)),
                                const SizedBox(height: 4),
                                Divider(
                                    height: 12,
                                    thickness: 2,
                                    indent: 18,
                                    endIndent: 18),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: screenHeight * .2,
                                      maxHeight: screenHeight * .6),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 3 / 1,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                    ),
                                    itemCount: allTags.length,
                                    itemBuilder: (context, index) {
                                      return CheckboxListTile(
                                        dense: true,
                                        title: Text(allTags[index].name,
                                            maxLines: 1),
                                        value: tagsChecked[index],
                                        onChanged: (_) => setState(() {
                                          tagsChecked[index] =
                                              !tagsChecked[index];
                                        }),
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                    height: 12,
                                    thickness: 2,
                                    indent: 18,
                                    endIndent: 18),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonWrapper(
                                      fillColor:
                                          Theme.of(context).primaryColorLight,
                                      splashColor:
                                          Theme.of(context).splashColor,
                                      elevation: 2,
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text('Cancel',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    ButtonWrapper(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      splashColor:
                                          Theme.of(context).splashColor,
                                      elevation: 2,
                                      onPressed: () => Navigator.of(context)
                                          .pop(tagsChecked),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text('Add Tags',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );

              if (boolList != null) {
                for (var i = 0; i < allTags.length; i++) {
                  if (boolList[i]) item.tags.add(allTags[i]);
                }
              }
            },
    );
  }
}
