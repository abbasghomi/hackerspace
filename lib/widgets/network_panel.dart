import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkPanel extends StatelessWidget {
  const NetworkPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Network status header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PACKETS:',
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      border: Border.all(color: Colors.red.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'INTERCEPTED',
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.red,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Network traffic list
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: state.networkTraffic.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = state.networkTraffic.length - 1 - index;
                      final traffic = state.networkTraffic[reversedIndex];

                      // Parse traffic data
                      final parts = traffic.split(' -> ');
                      final source = parts[0];
                      final destAndBytes = parts.length > 1 ? parts[1] : '';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Direction indicator
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.green.withOpacity(0.6),
                                  size: 10,
                                ),
                                const SizedBox(width: 4),

                                // Source IP
                                Expanded(
                                  child: Text(
                                    source,
                                    style: GoogleFonts.sourceCodePro(
                                      color: Colors.cyan,
                                      fontSize: 8,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            if (destAndBytes.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  destAndBytes,
                                  style: GoogleFonts.sourceCodePro(
                                    color: Colors.green.withOpacity(0.7),
                                    fontSize: 8,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Network statistics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'IN',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        '1.2MB/s',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'PORTS',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        'OPEN: 247',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.red,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'OUT',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green.withOpacity(0.7),
                          fontSize: 8,
                        ),
                      ),
                      Text(
                        '847KB/s',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
