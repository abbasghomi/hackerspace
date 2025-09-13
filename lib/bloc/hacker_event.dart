import 'package:equatable/equatable.dart';
import '../models/hacker_models.dart';

abstract class HackerEvent extends Equatable {
  const HackerEvent();

  @override
  List<Object> get props => [];
}

// System Events
class InitializeSystem extends HackerEvent {
  const InitializeSystem();
}

class LoginUser extends HackerEvent {
  final String username;
  final String password;

  const LoginUser(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LogoutUser extends HackerEvent {
  const LogoutUser();
}

class ChangeUserStatus extends HackerEvent {
  final UserStatus status;

  const ChangeUserStatus(this.status);

  @override
  List<Object> get props => [status];
}

// Terminal Events
class ExecuteCommand extends HackerEvent {
  final String command;

  const ExecuteCommand(this.command);

  @override
  List<Object> get props => [command];
}

class AddTerminalOutput extends HackerEvent {
  final String output;

  const AddTerminalOutput(this.output);

  @override
  List<Object> get props => [output];
}

class ClearTerminal extends HackerEvent {
  const ClearTerminal();
}

// Mission Events
class LoadMissions extends HackerEvent {
  const LoadMissions();
}

class StartMission extends HackerEvent {
  final String missionId;

  const StartMission(this.missionId);

  @override
  List<Object> get props => [missionId];
}

class CompleteMission extends HackerEvent {
  final String missionId;

  const CompleteMission(this.missionId);

  @override
  List<Object> get props => [missionId];
}

// Target Events
class ScanTarget extends HackerEvent {
  final String targetId;

  const ScanTarget(this.targetId);

  @override
  List<Object> get props => [targetId];
}

class ExploitTarget extends HackerEvent {
  final String targetId;
  final String exploitType;

  const ExploitTarget({
    required this.targetId,
    required this.exploitType,
  });

  @override
  List<Object> get props => [targetId, exploitType];
}

class AddTarget extends HackerEvent {
  final String name;
  final String ipAddress;

  const AddTarget(this.name, this.ipAddress);

  @override
  List<Object> get props => [name, ipAddress];
}

// Tool Events
class UnlockTool extends HackerEvent {
  final String toolId;

  const UnlockTool(this.toolId);

  @override
  List<Object> get props => [toolId];
}

class UseTool extends HackerEvent {
  final String toolId;
  final String targetId;

  const UseTool({
    required this.toolId,
    required this.targetId,
  });

  @override
  List<Object> get props => [toolId, targetId];
}

// Network Events
class ScanNetwork extends HackerEvent {
  const ScanNetwork();
}

class CompromiseNode extends HackerEvent {
  final String nodeId;

  const CompromiseNode(this.nodeId);

  @override
  List<Object> get props => [nodeId];
}

// System Mode Events
class ToggleRedAlert extends HackerEvent {
  const ToggleRedAlert();
}

class ToggleMatrixMode extends HackerEvent {
  const ToggleMatrixMode();
}

class ToggleGhostMode extends HackerEvent {
  const ToggleGhostMode();
}

class UpdateSystemIntegrity extends HackerEvent {
  final double integrity;

  const UpdateSystemIntegrity(this.integrity);

  @override
  List<Object> get props => [integrity];
}

class StartSystemTakeover extends HackerEvent {
  const StartSystemTakeover();
}

// New event for progressive takeover updates
class UpdateSystemTakeoverProgress extends HackerEvent {
  final int step;

  const UpdateSystemTakeoverProgress(this.step);

  @override
  List<Object> get props => [step];
}

// Experience and Achievement Events
class GainExperience extends HackerEvent {
  final int amount;

  const GainExperience(this.amount);

  @override
  List<Object> get props => [amount];
}

class UnlockAchievement extends HackerEvent {
  final String achievementName;

  const UnlockAchievement(this.achievementName);

  @override
  List<Object> get props => [achievementName];
}

// Advanced Feature Events
class PerformCryptanalysis extends HackerEvent {
  final String algorithm;
  final String ciphertext;

  const PerformCryptanalysis({
    required this.algorithm,
    required this.ciphertext,
  });

  @override
  List<Object> get props => [algorithm, ciphertext];
}

class LaunchSocialEngineering extends HackerEvent {
  final String targetId;
  final String method;

  const LaunchSocialEngineering({
    required this.targetId,
    required this.method,
  });

  @override
  List<Object> get props => [targetId, method];
}

class AnalyzeMalware extends HackerEvent {
  final String malwareType;
  final String sample;

  const AnalyzeMalware({
    required this.malwareType,
    required this.sample,
  });

  @override
  List<Object> get props => [malwareType, sample];
}

class CreateBackdoor extends HackerEvent {
  final String targetId;
  final String backdoorType;

  const CreateBackdoor({
    required this.targetId,
    required this.backdoorType,
  });

  @override
  List<Object> get props => [targetId, backdoorType];
}

class LaunchDDoSAttack extends HackerEvent {
  final String targetId;
  final String attackType;

  const LaunchDDoSAttack({
    required this.targetId,
    required this.attackType,
  });

  @override
  List<Object> get props => [targetId, attackType];
}

class PerformBlockchainAnalysis extends HackerEvent {
  final String blockchain;
  final String address;

  const PerformBlockchainAnalysis(this.blockchain, this.address);

  @override
  List<Object> get props => [blockchain, address];
}

class ExecuteQuantumDecryption extends HackerEvent {
  final String encryptedData;

  const ExecuteQuantumDecryption(this.encryptedData);

  @override
  List<Object> get props => [encryptedData];
}

class ActivateNeuralNetwork extends HackerEvent {
  final String networkType;
  final String task;

  const ActivateNeuralNetwork(this.networkType, this.task);

  @override
  List<Object> get props => [networkType, task];
}

// Automated System Events
class UpdateDataStream extends HackerEvent {
  const UpdateDataStream();
}

class UpdateNetworkTraffic extends HackerEvent {
  const UpdateNetworkTraffic();
}

class UpdateSystemLogs extends HackerEvent {
  const UpdateSystemLogs();
}


// Interactive Events - Missing event classes
class StartMatrixRain extends HackerEvent {
  const StartMatrixRain();
}

class StartNeuralPulse extends HackerEvent {
  const StartNeuralPulse();
}

class ActivateSystemScan extends HackerEvent {
  final String scanType;

  const ActivateSystemScan(this.scanType);

  @override
  List<Object> get props => [scanType];
}

class LaunchVirus extends HackerEvent {
  final String virusName;
  final String targetSystem;

  const LaunchVirus({
    required this.virusName,
    required this.targetSystem,
  });

  @override
  List<Object> get props => [virusName, targetSystem];
}

class InitiateBruteForce extends HackerEvent {
  final String target;
  final String attackType;

  const InitiateBruteForce({
    required this.target,
    required this.attackType,
  });

  @override
  List<Object> get props => [target, attackType];
}

class DeploySpyware extends HackerEvent {
  final String targetDevice;

  const DeploySpyware(this.targetDevice);

  @override
  List<Object> get props => [targetDevice];
}

class StartKeylogger extends HackerEvent {
  final String targetId;

  const StartKeylogger(this.targetId);

  @override
  List<Object> get props => [targetId];
}

class LaunchPhishingCampaign extends HackerEvent {
  final String campaignType;
  final List<String> targets;

  const LaunchPhishingCampaign({
    required this.campaignType,
    required this.targets,
  });

  @override
  List<Object> get props => [campaignType, targets];
}

class ActivateFirewall extends HackerEvent {
  final bool isEnabled;

  const ActivateFirewall(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}

class StartEncryption extends HackerEvent {
  final String encryptionType;
  final String data;

  const StartEncryption({
    required this.encryptionType,
    required this.data,
  });

  @override
  List<Object> get props => [encryptionType, data];
}

class LaunchAIAssistant extends HackerEvent {
  final String assistantType;

  const LaunchAIAssistant(this.assistantType);

  @override
  List<Object> get props => [assistantType];
}

class ActivateQuantumProcessor extends HackerEvent {
  const ActivateQuantumProcessor();
}

class StartDataMining extends HackerEvent {
  final String source;
  final String target;

  const StartDataMining({
    required this.source,
    required this.target,
  });

  @override
  List<Object> get props => [source, target];
}

class LaunchCyberAttack extends HackerEvent {
  final String attackVector;
  final String targetSystem;

  const LaunchCyberAttack({
    required this.attackVector,
    required this.targetSystem,
  });

  @override
  List<Object> get props => [attackVector, targetSystem];
}

class ActivateStealthMode extends HackerEvent {
  final int level;

  const ActivateStealthMode(this.level);

  @override
  List<Object> get props => [level];
}

class StartSystemMonitoring extends HackerEvent {
  const StartSystemMonitoring();
}

class LaunchCounterAttack extends HackerEvent {
  final String sourceAttack;

  const LaunchCounterAttack(this.sourceAttack);

  @override
  List<Object> get props => [sourceAttack];
}

class UpdateMatrixAnimation extends HackerEvent {
  const UpdateMatrixAnimation();
}

class UpdateNeuralConnections extends HackerEvent {
  const UpdateNeuralConnections();
}

class UpdateSystemPulse extends HackerEvent {
  const UpdateSystemPulse();
}

class UpdateHexDump extends HackerEvent {
  const UpdateHexDump();
}

class UpdateGeolocation extends HackerEvent {
  const UpdateGeolocation();
}

class UpdateProcessMonitor extends HackerEvent {
  const UpdateProcessMonitor();
}

class TriggerAlarmSequence extends HackerEvent {
  final String alarmType;

  const TriggerAlarmSequence(this.alarmType);

  @override
  List<Object> get props => [alarmType];
}

class StartProgressiveHack extends HackerEvent {
  final String targetName;
  final int stages;

  const StartProgressiveHack({
    required this.targetName,
    required this.stages,
  });

  @override
  List<Object> get props => [targetName, stages];
}

class UpdateProgressiveHack extends HackerEvent {
  final int currentStage;
  final String status;

  const UpdateProgressiveHack({
    required this.currentStage,
    required this.status,
  });

  @override
  List<Object> get props => [currentStage, status];
}
