import 'package:inventory_plus/global_h.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CodeScanner extends StatefulWidget {
  final double? size;

  const CodeScanner({super.key, this.size});

  @override
  State<CodeScanner> createState() => _CodeScannerState();
}

class _CodeScannerState extends State<CodeScanner> {
  String barcodeScanResponse = '';

  @override
  Widget build(BuildContext context) {
    Tag tag;

    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.qr_code_scanner, size: widget.size),
      tooltip: 'Code Scanner',
      onPressed: () => scanCode().then(
        (wasScanned) => {
          if (wasScanned)
            {
              if (barcodeScanResponse.contains('tag'))
                {
                  tag = Provider.of<Tags>(context, listen: false)
                      .findById(barcodeScanResponse.split('/')[2]),
                  if (!tag.name.isWhitespace())
                    {
                      Navigator.of(context)
                          .pushNamed(tagDetailRoute, arguments: tag),
                    }
                  else
                    {
                      Navigator.of(context).pop(),
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Tag QR Code but no Tag found'))),
                    }
                }
              else
                {
                  Navigator.of(context).pushNamed(scanHandlerRoute,
                      arguments: barcodeScanResponse)
                }
            }
        },
      ),
    );
  }

  Future<bool> scanCode() async {
    try {
      barcodeScanResponse = await FlutterBarcodeScanner.scanBarcode(
          '#ededed', 'X', true, ScanMode.QR);
      if (kDebugMode) print(barcodeScanResponse);
    } on PlatformException {
      barcodeScanResponse = 'Failed scanning code';
      return false;
    }
    if (!mounted) return false;
    return true;
  }
}
