const List<String> dummyUserImageUrls = const [
  'https://randomuser.me/api/portraits/men/67.jpg',
  'https://randomuser.me/api/portraits/women/40.jpg',
];

String dummyTagImageUrlPicker(String name) {
  if (name.contains(RegExp(r'room', caseSensitive: false)))
    return dummyTagImageUrls[3];
  if (name.contains(RegExp(r'garage|car', caseSensitive: false)))
    return dummyTagImageUrls[2];
  if (name.contains(RegExp(r'book|library', caseSensitive: false)))
    return dummyTagImageUrls[1];
  return dummyTagImageUrls[0];
}

const List<String> dummyTagImageUrls = const [
  'https://unsplash.com/photos/CHKaD8uRaDU/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODE3NTY4&force=true&w=640', // shoes
  'https://unsplash.com/photos/lUaaKCUANVI/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODExMzIx&force=true&w=640', // books
  'https://unsplash.com/photos/A53o1drQS2k/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODE3NTAz&force=true&w=640', // cars
  'https://unsplash.com/photos/psrloDbaZc8/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8Nnx8ZGlydHklMjBraWRzJTIwYmVkcm9vbXxlbnwwfHx8fDE2NTk5NjQ3NTc&force=true&w=640', // room
];

String dummyItemImageUrlPicker(String name) {
  if (name.contains(RegExp(r'book', caseSensitive: false)))
    return dummyRecItemImageUrls[name.hashCode % 3];
  if (name.contains(RegExp(r'blanket', caseSensitive: false)))
    return dummyItemImageUrls[9];
  if (name.contains(RegExp(r'camaro', caseSensitive: false)))
    return dummyItemImageUrls[8];
  if (name.contains(RegExp(r'porsche', caseSensitive: false)))
    return dummyItemImageUrls[7];
  if (name.contains(RegExp(r'aston', caseSensitive: false)))
    return dummyItemImageUrls[6];
  if (name.contains(RegExp(r'bug|volks|car', caseSensitive: false)))
    return dummyItemImageUrls[5];
  return dummyItemImageUrls[name.hashCode % 5];
}

const List<String> dummyItemImageUrls = const [
  'https://sneakernews.com/wp-content/uploads/2020/11/Air-Jordan-1-University-Blue-GS-575441-134.jpg', // mens jordans
  'https://static.nike.com/a/images/t_prod_ss/w_960,c_limit,f_auto/421edc77-56e9-42d4-b60a-f3bfa00f272b/women-s-air-jordan-1-seafoam-release-date.jpg', // womens jordans
  'https://cdn.flightclub.com/750/TEMPLATE/172524/2.jpg', // blue jordans
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc7EbU1zsyYhkIP0NYVpqctWjW-tIEbc5S6NZM_cHNQtKS7vha6QL6pD4iut-bGG75VZo&usqp=CAU', // white nikes
  'https://classic.cdn.media.amplience.net/i/hibbett/2P781_7130_left2', // neon nikes
  'https://unsplash.com/photos/N7RiDzfF2iw/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODA5NDE0&force=true&w=640', // car 1 bug
  'https://unsplash.com/photos/PcbJL9CYSXs/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODE3MzQw&force=true&w=640', // car 2 aston martin
  'https://unsplash.com/photos/Aqt08E8JzEc/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODAyOTQ0&force=true&w=640', // car 3 old porsche
  'https://unsplash.com/photos/d22EgbYSjQc/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5OTY2MDI4&force=true&w=640', // car 4 new camaro
  'https://unsplash.com/photos/dw7paFI1jnM/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5OTY2MjMz&force=true&w=640', // grandmas blanky
];

const List<String> dummyRecItemImageUrls = const [
  'https://unsplash.com/photos/RrhhzitYizg/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODA4Njg4&force=true&w=640', // book 1
  'https://unsplash.com/photos/pFnvc1Cu6zI/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODE3MTU2&force=true&w=640', // book 2
  'https://unsplash.com/photos/HXjtPt_XRAQ/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU5ODAwMTY5&force=true&w=640', // book 3
];
