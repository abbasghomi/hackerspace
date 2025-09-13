import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:math';

class ProcessMonitorPanel extends StatefulWidget {
  const ProcessMonitorPanel({super.key});

  @override
  State<ProcessMonitorPanel> createState() => _ProcessMonitorPanelState();
}

class _ProcessMonitorPanelState extends State<ProcessMonitorPanel> {
  final List<ProcessInfo> _processes = [];
  Timer? _processTimer;
  final Random _random = Random();

  final List<String> _processNames = [
    'svchost.exe',
    'explorer.exe',
    'chrome.exe',
    'notepad.exe',
    'cmd.exe',
    'powershell.exe',
    'winlogon.exe',
    'csrss.exe',
    'lsass.exe',
    'spoolsv.exe',
    'backdoor.exe',
    'keylogger.exe',
    'trojan.exe',
    'rootkit.sys',
  ];

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  @override
  void dispose() {
    _processTimer?.cancel();
    super.dispose();
  }

  void _startMonitoring() {
    _processTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      _updateProcesses();
    });
  }

  void _updateProcesses() {
    if (_processes.length > 12) {
      _processes.removeAt(0);
    }

    final processName = _processNames[_random.nextInt(_processNames.length)];
    final isMalicious = processName.contains('backdoor') ||
                      processName.contains('keylogger') ||
                      processName.contains('trojan') ||
                      processName.contains('rootkit');

    final process = ProcessInfo(
      pid: 1000 + _random.nextInt(9000),
      name: processName,
      memoryUsage: '${_random.nextInt(500) + 10}MB',
      cpuUsage: '${_random.nextInt(100)}%',
      status: isMalicious ? 'MALICIOUS' : 'NORMAL',
      threads: _random.nextInt(50) + 1,
    );

    _processes.add(process);
    if (mounted) setState(() {});
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
                'PROCESS MONITOR',
                style: GoogleFonts.sourceCodePro(
                  color: const Color(0xFF00FF00),
                  fontSize: 9,
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
                  '${_processes.where((p) => p.status == "MALICIOUS").length} MALWARE',
                  style: GoogleFonts.sourceCodePro(
                    color: Colors.red,
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
              child: ListView.builder(
                itemCount: _processes.length,
                itemBuilder: (context, index) {
                  final process = _processes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${process.name} (${process.pid})',
                                style: GoogleFonts.sourceCodePro(
                                  color: process.status == "MALICIOUS"
                                      ? Colors.red
                                      : const Color(0xFF00FF00),
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                              decoration: BoxDecoration(
                                color: process.status == "MALICIOUS"
                                    ? Colors.red.withOpacity(0.2)
                                    : const Color(0xFF00FF00).withOpacity(0.2),
                                border: Border.all(
                                  color: process.status == "MALICIOUS"
                                      ? Colors.red.withOpacity(0.6)
                                      : const Color(0xFF00FF00).withOpacity(0.6),
                                ),
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: Text(
                                process.status,
                                style: GoogleFonts.sourceCodePro(
                                  color: process.status == "MALICIOUS"
                                      ? Colors.red
                                      : const Color(0xFF00FF00),
                                  fontSize: 6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MEM: ${process.memoryUsage}',
                              style: GoogleFonts.sourceCodePro(
                                color: const Color(0xFF00FF00).withOpacity(0.8),
                                fontSize: 7,
                              ),
                            ),
                            Text(
                              'CPU: ${process.cpuUsage}',
                              style: GoogleFonts.sourceCodePro(
                                color: const Color(0xFF00FF00).withOpacity(0.8),
                                fontSize: 7,
                              ),
                            ),
                            Text(
                              'THR: ${process.threads}',
                              style: GoogleFonts.sourceCodePro(
                                color: const Color(0xFF00FF00).withOpacity(0.8),
                                fontSize: 7,
                              ),
                            ),
                          ],
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
                'INJECTED: ${_processes.where((p) => p.name.contains(".exe") && p.status == "MALICIOUS").length}',
                style: GoogleFonts.sourceCodePro(
                  color: Colors.red,
                  fontSize: 8,
                ),
              ),
              Text(
                'TOTAL: ${_processes.length}',
                style: GoogleFonts.sourceCodePro(
                  color: const Color(0xFF00FF00),
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

class ProcessInfo {
  final int pid;
  final String name;
  final String memoryUsage;
  final String cpuUsage;
  final String status;
  final int threads;

  ProcessInfo({
    required this.pid,
    required this.name,
    required this.memoryUsage,
    required this.cpuUsage,
    required this.status,
    required this.threads,
  });
}
