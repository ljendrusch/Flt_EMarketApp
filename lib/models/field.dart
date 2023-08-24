import 'package:inventory_plus/global_h.dart';

Field fieldFromJson(String data) =>
    Field.fromJson(jsonDecode(data) as Map<String, dynamic>);
Map<String, dynamic> fieldToJson(Field data) => data.toJson();

class Field {
  FieldType type;
  String name;
  String value;

  Field({
    this.type = FieldType.text,
    this.name = '',
    this.value = '',
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        type: stringTypeMap[
                handleNull(DataType.string, json['type']) as String] ??
            FieldType.empty,
        name: handleNull(DataType.string, json['name']) as String,
        value: handleNull(DataType.string, json['value']) as String,
      );

  Map<String, dynamic> toJson() => {
        'type': typeStringMap[type],
        'name': name,
        'value': value,
      };
}

Map<String, FieldType> stringTypeMap = {
  '': FieldType.empty,
  'text': FieldType.text,
  'date': FieldType.date,
  'color': FieldType.color,
  'number': FieldType.number,
};

Map<FieldType, String> typeStringMap = {
  FieldType.empty: '',
  FieldType.text: 'text',
  FieldType.date: 'date',
  FieldType.color: 'color',
  FieldType.number: 'number',
};
