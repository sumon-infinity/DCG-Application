import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  MobileScannerController controller = MobileScannerController();
  bool _isFlashOn = false;
  String? _result;

  void _showResultDialog(String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Code Result'),
        content: Text(code),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _result = null;
              });
            },
            child: const Text('Scan Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/home');
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(_isFlashOn ? FeatherIcons.zap : FeatherIcons.zapOff),
            onPressed: () {
              controller.toggleTorch();
              setState(() {
                _isFlashOn = !_isFlashOn;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty && _result == null) {
                      setState(() {
                        _result = barcodes.first.rawValue;
                      });
                      if (_result != null) {
                        _showResultDialog(_result!);
                      }
                    }
                  },
                ),
                CustomPaint(
                  painter: ScannerOverlay(
                    borderColor: Theme.of(context).primaryColor,
                  ),
                  child: const SizedBox.expand(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Align QR code within the frame to scan',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  final Color borderColor;

  ScannerOverlay({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final scanArea = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.8,
      height: size.width * 0.8,
    );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final path = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()..addRect(scanArea),
    );

    canvas.drawPath(path, backgroundPaint);
    canvas.drawRect(scanArea, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) => false;
}
