import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';

class CryptoPanel extends StatefulWidget {
  const CryptoPanel({super.key});

  @override
  State<CryptoPanel> createState() => _CryptoPanelState();
}

class _CryptoPanelState extends State<CryptoPanel> {
  final List<CipherAttempt> _attempts = [];
  Timer? _crackTimer;
  final Random _random = Random();
  double _progress = 0.0;

  final List<String> _cipherTypes = [
    'AES-256-CBC',
    'RSA-2048',
    'SHA-256',
    'Blowfish',
    'DES-3',
    'ChaCha20',
    'Twofish',
    'Serpent',
  ];

  final List<String> _methods = [
    'Brute Force',
    'Dictionary Attack',
    'Rainbow Table',
    'Side Channel',
    'Differential Crypto',
    'Linear Cryptanalysis',
    'Frequency Analysis',
    'Known Plaintext',
  ];

  @override
  void initState() {
    super.initState();
    _startCracking();
  }

  @override
  void dispose() {
    _crackTimer?.cancel();
    super.dispose();
  }

  void _startCracking() {
    _crackTimer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      _addCipherAttempt();
      _updateProgress();
    });
  }

  void _addCipherAttempt() {
    if (_attempts.length > 12) {
      _attempts.removeAt(0);
    }

    final success = _random.nextDouble() > 0.85;
    final attempt = CipherAttempt(
      cipher: _cipherTypes[_random.nextInt(_cipherTypes.length)],
      method: _methods[_random.nextInt(_methods.length)],
      keyLength: [128, 192, 256, 512, 1024, 2048][_random.nextInt(6)],
      status: success ? 'CRACKED' : 'ANALYZING',
      timeElapsed: '${_random.nextInt(300)}s',
    );

    _attempts.add(attempt);
    if (mounted) setState(() {});
  }

  void _updateProgress() {
    _progress = (_progress + 0.03) % 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CIPHER ANALYSIS',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.purple,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'QUANTUM READY',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.cyan,
                  fontSize: 8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          Row(
            children: [
              Text(
                'PROGRESS:',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.purple.withOpacity(0.7),
                  fontSize: 8,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(_progress * 100).toInt()}%',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.purple,
                  fontSize: 8,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(2),
              ),
              child: ListView.builder(
                itemCount: _attempts.length,
                itemBuilder: (context, index) {
                  final attempt = _attempts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              attempt.cipher,
                              style: GoogleFonts.sourceCodePro(
                                color: Colors.cyan,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                              decoration: BoxDecoration(
                                color: attempt.status == 'CRACKED'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.orange.withOpacity(0.2),
                                border: Border.all(
                                  color: attempt.status == 'CRACKED'
                                      ? Colors.green.withOpacity(0.6)
                                      : Colors.orange.withOpacity(0.6),
                                ),
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: Text(
                                attempt.status,
                                style: GoogleFonts.sourceCodePro(
                                  color: attempt.status == 'CRACKED' ? Colors.green : Colors.orange,
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${attempt.method} | ${attempt.keyLength}-bit | ${attempt.timeElapsed}',
                          style: GoogleFonts.sourceCodePro(
                            color: Colors.purple.withOpacity(0.8),
                            fontSize: 7,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CRACKED: ${_attempts.where((a) => a.status == 'CRACKED').length}',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.green,
                  fontSize: 8,
                ),
              ),
              Text(
                'KEYSPACE: 2^256',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.purple,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CipherAttempt {
  final String cipher;
  final String method;
  final int keyLength;
  final String status;
  final String timeElapsed;

  CipherAttempt({
    required this.cipher,
    required this.method,
    required this.keyLength,
    required this.status,
    required this.timeElapsed,
  });
}
