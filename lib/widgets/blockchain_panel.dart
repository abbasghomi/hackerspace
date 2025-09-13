import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';

class BlockchainPanel extends StatelessWidget {
  const BlockchainPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HackerBloc, HackerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BLOCKCHAIN FORENSICS',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.2),
                      border: Border.all(color: Colors.yellow.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'TRACING',
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.yellow,
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                      ),
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
                    border: Border.all(color: const Color(0xFF00FF00).withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WALLET ANALYSIS:',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.yellow,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'BTC: 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00),
                          fontSize: 7,
                        ),
                      ),
                      Text(
                        'Balance: 50.00000000 BTC',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.yellow,
                          fontSize: 7,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'TRANSACTION HISTORY:',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.yellow,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: ListView(
                          children: [
                            _buildTransactionEntry('2024-09-12 14:30', '+10.5 BTC', 'RECEIVED'),
                            _buildTransactionEntry('2024-09-11 09:15', '-2.1 BTC', 'SENT'),
                            _buildTransactionEntry('2024-09-10 16:45', '+5.7 BTC', 'RECEIVED'),
                            _buildTransactionEntry('2024-09-09 11:20', '-1.3 BTC', 'SENT'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RISK SCORE: HIGH',
                            style: GoogleFonts.sourceCodePro(
                              color: Colors.red,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => context.read<HackerBloc>().add(
                              const PerformBlockchainAnalysis('Bitcoin', '1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa')
                            ),
                            child: Text(
                              'DEEP SCAN',
                              style: GoogleFonts.sourceCodePro(
                                color: Colors.cyan,
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionEntry(String date, String amount, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: GoogleFonts.sourceCodePro(
              color: const Color(0xFF00FF00).withOpacity(0.8),
              fontSize: 6,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.sourceCodePro(
              color: amount.startsWith('+') ? Colors.green : Colors.red,
              fontSize: 6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            type,
            style: GoogleFonts.sourceCodePro(
              color: const Color(0xFF00FF00).withOpacity(0.6),
              fontSize: 6,
            ),
          ),
        ],
      ),
    );
  }
}
