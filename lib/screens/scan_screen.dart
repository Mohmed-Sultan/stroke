import 'package:flutter/material.dart';
import '../core/core.dart'; // import your MyColors definition here

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scanAnimation = Tween<double>(begin: 0.0, end: 248.0).animate(_animationController);
  }

  void _startScan() async {
    setState(() {
      _isScanning = true;
    });

    _animationController.repeat(reverse: true);

    // Simulated scan process
    await Future.delayed(Duration(seconds: 5));
    _animationController.stop();

    setState(() {
      _isScanning = false;
    });
  }

  Widget _buildScanOverlay() {
    return Positioned(
      top: _scanAnimation.value,
      left: 0,
      right: 0,
      child: Container(
        height: 2,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.tune, color: MyColors.mainColor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.shuffle, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.face_retouching_natural, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 30),

          // Image with Scan Overlay
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.mainColor, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      'assets/images/xray.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (_isScanning) _buildScanOverlay(),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),

// Start Scan Button
          ElevatedButton.icon(
            onPressed: _isScanning ? null : _startScan,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.mainColor,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            icon: Icon(Icons.qr_code_scanner, color: Colors.white),
            label: Text(
              _isScanning ? 'Scanning...' : 'Start Scan',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          // Bottom Scanning Message
          if (_isScanning)
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Icon(Icons.scanner, color: Colors.white, size: 30),
                  SizedBox(height: 5),
                  Text(
                    "Scanning...",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}