import 'package:inventory_plus/global_h.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TextFormFieldShortcut extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?) onSaved;
  final bool isPassword;
  final TextInputType keyboardType;
  final List<FilteringTextInputFormatter>? inputFormatters;

  const TextFormFieldShortcut({
    super.key,
    this.initialValue = '',
    this.labelText = '',
    required this.validator,
    this.onChanged,
    required this.onSaved,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      obscureText: isPassword,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}

class DateFormFieldShortcut extends StatefulWidget {
  final String initialValue;
  final String labelText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?) onSaved;

  const DateFormFieldShortcut({
    super.key,
    this.initialValue = '',
    this.labelText = '',
    required this.validator,
    this.onChanged,
    required this.onSaved,
  });

  @override
  State<DateFormFieldShortcut> createState() => _DateFormFieldShortcutState();
}

class _DateFormFieldShortcutState extends State<DateFormFieldShortcut> {
  TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: widget.labelText,
      ),
      controller: dateinput,
      onSaved: widget.onSaved,
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context)
                      .colorScheme
                      .primary, // header background color
                  onPrimary: Theme.of(context)
                      .colorScheme
                      .onPrimary, // header text color
                  onSurface: Theme.of(context)
                      .colorScheme
                      .onSurface, // body text color
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          final String formattedDate =
              DateFormat('yyyy-MM-dd').format(pickedDate);

          setState(() {
            dateinput.text =
                formattedDate; //set output date to TextField value.
          });
        }
      },
    );
  }
}

class ColorFormFieldShortcut extends StatefulWidget {
  final Field field;

  const ColorFormFieldShortcut({super.key, required this.field});

  @override
  State<ColorFormFieldShortcut> createState() => _ColorFormFieldShortcutState();
}

class _ColorFormFieldShortcutState extends State<ColorFormFieldShortcut> {
  Color pickerColor = const Color(0xff000000);
  Color currentColor = const Color(0xff000000);

  @override
  void initState() {
    if (widget.field.value.isNotEmpty) {
      pickerColor = Color(int.parse(widget.field.value)).withOpacity(1);
      currentColor = Color(int.parse(widget.field.value)).withOpacity(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: false,
          maintainState: true,
          child: TextFormField(
            onSaved: (String? value) {
              widget.field.value = currentColor.value.toString();
            },
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: currentColor,
            side: const BorderSide(
              color: Colors.grey,
            ),
          ),
          child: const Text(''),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Pick a color',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: currentColor,
                      onColorChanged: (Color color) =>
                          setState(() => pickerColor = color),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Use'),
                      onPressed: () {
                        setState(() => currentColor = pickerColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
