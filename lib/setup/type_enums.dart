enum ArgType {
  tabIndex,
  inventoryTabIndex,
  item,
  tag,
  tags,
  onSubmit,
  onSave,
  formKey,
  upc,
  value,
  url,
  objName,
}

enum FieldType {
  empty,
  text,
  date,
  color,
  number,
}

enum DataType {
  number,
  decimal,
  string,
  date,
  list,
  bool,
}

enum ImageType {
  file,
  url,
  asset,
}

enum ViewMode {
  list,
  grid,
}

enum FetchState {
  init, // no http request initiated
  loading, // http request made, no response yet
  success, // successful response (200) received
  error, // any error; connection timeout, 403, no internet connection, etc.
}
