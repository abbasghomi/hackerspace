import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hackerspace/bloc/hacker_bloc.dart';
import 'package:hackerspace/bloc/hacker_event.dart';
import 'package:hackerspace/bloc/hacker_state.dart';
import 'package:hackerspace/models/hacker_models.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('HackerBloc', () {
    late HackerBloc hackerBloc;

    setUpAll(() {
      // Set up mock for SharedPreferences
      SharedPreferences.setMockInitialValues({
        'username': 'test_user',
        'level': 5,
        'experience': 1000,
      });
    });

    setUp(() {
      hackerBloc = HackerBloc();
    });

    tearDown(() {
      hackerBloc.close();
    });

    test('initial state is correct', () {
      expect(hackerBloc.state, const HackerState());
    });

    group('InitializeSystem', () {
      blocTest<HackerBloc, HackerState>(
        'initializes system with all components',
        build: () => HackerBloc(),
        act: (bloc) => bloc.add(const InitializeSystem()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          const HackerState(isLoading: true),
          predicate<HackerState>((state) {
            return !state.isLoading &&
                state.terminalOutput.isNotEmpty;
          }),
        ],
      );
    });

    group('LoginUser', () {
      blocTest<HackerBloc, HackerState>(
        'emits loading and success state for valid credentials',
        build: () => HackerBloc(),
        act: (bloc) => bloc.add(const LoginUser(
          'testuser',
          'password123',
        )),
        wait: const Duration(seconds: 3),
        expect: () => [
          const HackerState(isLoading: true),
          predicate<HackerState>((state) {
            return !state.isLoading &&
                state.user != null &&
                state.user!.username == 'testuser';
          }),
        ],
      );

      blocTest<HackerBloc, HackerState>(
        'emits error state for empty credentials',
        build: () => HackerBloc(),
        act: (bloc) => bloc.add(const LoginUser(
          '',
          '',
        )),
        wait: const Duration(seconds: 3),
        expect: () => [
          const HackerState(isLoading: true),
          predicate<HackerState>((state) {
            return !state.isLoading &&
                state.error != null &&
                state.error!.contains('Invalid credentials');
          }),
        ],
      );
    });

    group('LogoutUser', () {
      blocTest<HackerBloc, HackerState>(
        'clears user and adds logout message',
        build: () => HackerBloc(),
        seed: () => HackerState(
          user: HackerUser(
            id: 'test-id',
            username: 'testuser',
            level: 1,
            experience: 0,
            achievements: const [],
            lastLoginTime: DateTime.now(),
            status: UserStatus.normal,
          ),
        ),
        act: (bloc) => bloc.add(const LogoutUser()),
        expect: () => [
          predicate<HackerState>((state) {
            return state.user == null;
          }),
        ],
      );
    });

    group('ChangeUserStatus', () {
      blocTest<HackerBloc, HackerState>(
        'updates user status and system modes',
        build: () => HackerBloc(),
        seed: () => HackerState(
          user: HackerUser(
            id: 'test-id',
            username: 'testuser',
            level: 1,
            experience: 0,
            achievements: const [],
            lastLoginTime: DateTime.now(),
            status: UserStatus.normal,
          ),
        ),
        act: (bloc) => bloc.add(const ChangeUserStatus(UserStatus.ghost)),
        expect: () => [
          predicate<HackerState>((state) {
            return state.user?.status == UserStatus.ghost;
          }),
        ],
      );
    });

    group('ExecuteCommand', () {
      blocTest<HackerBloc, HackerState>(
        'executes help command',
        build: () => HackerBloc(),
        act: (bloc) => bloc.add(const ExecuteCommand('help')),
        expect: () => [
          predicate<HackerState>((state) {
            return state.terminalOutput.any((output) => output.contains('help'));
          }),
        ],
      );

      blocTest<HackerBloc, HackerState>(
        'executes scan command',
        build: () => HackerBloc(),
        act: (bloc) => bloc.add(const ExecuteCommand('scan')),
        expect: () => [
          predicate<HackerState>((state) {
            return state.terminalOutput.any((output) => output.contains('scan'));
          }),
        ],
      );

      blocTest<HackerBloc, HackerState>(
        'handles unknown command',
        build: () => HackerBloc(),
        act: (bloc) => bloc.add(const ExecuteCommand('unknown_command')),
        expect: () => [
          predicate<HackerState>((state) {
            return state.terminalOutput.any((output) =>
                output.contains('Command not found') ||
                output.contains('unknown_command'));
          }),
        ],
      );
    });

    group('GainExperience', () {
      blocTest<HackerBloc, HackerState>(
        'increases user experience',
        build: () => HackerBloc(),
        seed: () => HackerState(
          user: HackerUser(
            id: 'test-id',
            username: 'testuser',
            level: 1,
            experience: 90,
            achievements: const [],
            lastLoginTime: DateTime.now(),
            status: UserStatus.normal,
          ),
        ),
        act: (bloc) => bloc.add(const GainExperience(50)),
        expect: () => [
          predicate<HackerState>((state) {
            return state.user!.experience >= 140;
          }),
        ],
      );
    });
  });
}
