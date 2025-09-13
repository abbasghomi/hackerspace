import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/hacker_bloc.dart';
import '../bloc/hacker_state.dart';
import '../bloc/hacker_event.dart';

class NeuralNetworkPanel extends StatelessWidget {
  const NeuralNetworkPanel({super.key});

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
                    'NEURAL NETWORK',
                    style: GoogleFonts.sourceCodePro(
                      color: const Color(0xFF00FF00),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      border: Border.all(color: Colors.purple.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'ACTIVE',
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.purple,
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
                        'PATTERN RECOGNITION: 98.7%',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.purple,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildNeuralLayer('INPUT LAYER', 784, Colors.cyan),
                      _buildNeuralLayer('HIDDEN 1', 256, Colors.purple),
                      _buildNeuralLayer('HIDDEN 2', 128, Colors.purple),
                      _buildNeuralLayer('OUTPUT', 10, Colors.green),
                      const SizedBox(height: 8),
                      Text(
                        'TRAINING DATA:',
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.purple,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '• Network Traffic: 2.5M packets',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00).withOpacity(0.8),
                          fontSize: 7,
                        ),
                      ),
                      Text(
                        '• Malware Signatures: 850K samples',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00).withOpacity(0.8),
                          fontSize: 7,
                        ),
                      ),
                      Text(
                        '• User Behavior: 1.2M sessions',
                        style: GoogleFonts.sourceCodePro(
                          color: const Color(0xFF00FF00).withOpacity(0.8),
                          fontSize: 7,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ACCURACY: 99.3%',
                            style: GoogleFonts.sourceCodePro(
                              color: Colors.green,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => context.read<HackerBloc>().add(
                              const ActivateNeuralNetwork('Deep Learning', 'pattern_recognition')
                            ),
                            child: Text(
                              'ENHANCE',
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

  Widget _buildNeuralLayer(String name, int neurons, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              name,
              style: GoogleFonts.sourceCodePro(
                color: color.withOpacity(0.8),
                fontSize: 6,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.8),
                    color.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$neurons',
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
