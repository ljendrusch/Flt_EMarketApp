export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'dart:math';

export 'package:flutter/foundation.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:provider/provider.dart';

// ----- uncomment a following export to make the  -----
// ----- respective package available globablly    -----

// export 'package:animated_splash_screen/animated_splash_screen.dart';
// export 'package:flex_color_scheme/flex_color_scheme.dart'
//     hide FlexStringExtensions;
// export 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// export 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// export 'package:font_awesome_flutter/font_awesome_flutter.dart';
// export 'package:google_fonts/google_fonts.dart';
// export 'package:hive/hive.dart';
// export 'package:hive_flutter/hive_flutter.dart';
// export 'package:image_picker/image_picker.dart';
// export 'package:page_transition/page_transition.dart';
// export 'package:path/path.dart' hide Context;
// export 'package:url_launcher/url_launcher.dart';

export 'inventory_app.dart';
export 'crafted_widgets/crafted_widgets_h.dart';
export 'models/models_h.dart';
export 'providers/providers_h.dart';
export 'screens/screens_h.dart';
export 'setup/setup_h.dart';

late double screenWidth;
late double screenHeight;

const String splashRoute = '/splash';
const String loginRoute = '/login';
const String homeRoute = '/';
const String inventoryRoute = '/inventory';
const String searchRoute = '/search';
const String profileRoute = '/profile';
const String itemDetailRoute = '/itemDetails';
const String tagDetailRoute = '/tagDetails';
const String itemFormRoute = '/itemForm';
const String tagFormRoute = '/tagForm';
const String scanHandlerRoute = '/scanHandler';
const String helpCenterRoute = '/helpcenter';
