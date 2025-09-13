import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';

class QuantumPanel extends StatelessWidget {
  const QuantumPanel({super.key});

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
                    'QUANTUM DECRYPT',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withValues(alpha: 0.2),
                      border: Border.all(color: Colors.cyan.withValues(alpha: 0.5)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'SUPERPOSITION',
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.cyan,
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
                    color: Colors.black.withValues(alpha: 0.8),
                    border: Border.all(color: const Color(0xFF00FF00).withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QUANTUM STATE: |Ψ⟩ = α|0⟩ + β|1⟩',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.cyan,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildQuantumBit('QUBIT 1', 0.8, Colors.cyan),
                      _buildQuantumBit('QUBIT 2', 0.6, Colors.cyan),
                      _buildQuantumBit('QUBIT 3', 0.9, Colors.cyan),
                      _buildQuantumBit('QUBIT 4', 0.4, Colors.cyan),
                      const SizedBox(height: 8),
                      Text(
                        'SHOR\'S ALGORITHM: ACTIVE',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.cyan,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '• RSA-2048: 47% complete',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00).withValues(alpha: 0.8),
                          fontSize: 7,
                        ),
                      ),
                      Text(
                        '• ECC-256: Factorizing...',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00).withValues(alpha: 0.8),
                          fontSize: 7,
                        ),
                      ),
                      Text(
                        '• Post-Quantum Ready: YES',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.green,
                          fontSize: 7,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'ENTANGLEMENT PAIRS: 2048',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.purple,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'COHERENCE: 99.7%',
                            style: GoogleFonts.sourceCodePro(
                              color: Colors.green,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => context.read<HackerBloc>().add(
                              const ExecuteQuantumDecryption('quantum_encrypted_data')
                            ),
                            child: Text(
                              'DECRYPT',
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

  Widget _buildQuantumBit(String name, double coherence, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              name,
              style: GoogleFonts.sourceCodePro(
                color: color.withValues(alpha: 0.8),
                fontSize: 6,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: coherence),
                        color.withValues(alpha: coherence * 0.5),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '${(coherence * 100).toInt()}%',
            style: GoogleFonts.sourceCodePro(
              color: color,
              fontSize: 6,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
