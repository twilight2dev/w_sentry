import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:w_sentry/data/enum/drone_status.dart';
import 'package:w_sentry/data/model/server_model.dart';
import 'package:w_sentry/data/repository/repository.dart';
import 'package:w_sentry/data/repository/sentry_repository.dart';
import 'package:w_sentry/presentation/screens/home/home_state.dart';

final homeVMProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(ref.watch(sentryRepositoryProvider));
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._sentryRepository) : super(HomeState());

  final SentryRepository _sentryRepository;

  void init() {
    state = state.copyWith(status: HomeStatus.checking_health);
    checkHealth();
  }

  Future<void> checkHealth() async {
    final result = await _sentryRepository.getServerList();
    result.when(
      success: (data) async {
        final servers = data ?? [];
        final futures = servers.map((server) => _checkServerHealth(server)).toList();
        await Future.wait(futures);
        state = state.copyWith(
          status: HomeStatus.check_health_success,
          servers: servers,
        );
      },
      failure: (error) {
        state = state.copyWith(status: HomeStatus.check_health_failure);
      },
    );
  }

  Future<void> _checkServerHealth(ServerModel server) async {
    if (server.url != null) {
      final result = await _sentryRepository.checkHealth(server.url!);
      result.when(
        success: (data) async {
          server.isActive = data ?? false;
        },
        failure: (error) {
          //
        },
      );
    }
  }

  Future<void> stopServer() async {
    state = state.copyWith(status: HomeStatus.stop_server_inprogress);
    final result = await _sentryRepository.stopServer();
    result.when(
      success: (data) async {
        final jobId = data?.number;
        if (jobId != null) {
          _checkJob(jobId, start: false);
        } else {
          state = state.copyWith(status: HomeStatus.stop_server_failure);
        }
      },
      failure: (error) {
        state = state.copyWith(status: HomeStatus.stop_server_failure);
      },
    );
  }

  Future<void> startServer() async {
    state = state.copyWith(status: HomeStatus.start_server_inprogress);
    final result = await _sentryRepository.startServer();
    result.when(
      success: (data) async {
        final jobId = data?.number;
        if (jobId != null) {
          _checkJob(jobId);
        } else {
          state = state.copyWith(status: HomeStatus.start_server_failure);
        }
      },
      failure: (error) {
        state = state.copyWith(status: HomeStatus.start_server_failure);
      },
    );
  }

  Future<void> _checkJob(int jobId, {bool start = true}) async {
    final result = await _sentryRepository.getJobDetail(jobId);
    await result.when(
      success: (data) async {
        final jobStatus = data?.status ?? DroneStatus.failure;
        switch (jobStatus) {
          case DroneStatus.running:
            _checkJob(jobId, start: start);
            break;
          case DroneStatus.success:
            state = state.copyWith(status: start ? HomeStatus.start_server_success : HomeStatus.stop_server_success);
            checkHealth();
            break;
          default:
            state = state.copyWith(status: start ? HomeStatus.start_server_failure : HomeStatus.stop_server_failure);
            break;
        }
      },
      failure: (error) {
        state = state.copyWith(status: start ? HomeStatus.start_server_failure : HomeStatus.stop_server_failure);
      },
    );
  }
}
