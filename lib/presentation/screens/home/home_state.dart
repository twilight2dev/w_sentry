import 'package:w_sentry/data/model/server_model.dart';

enum HomeStatus {
  initial,
  checking_health,
  check_health_failure,
  check_health_success,
  start_server_inprogress,
  start_server_failure,
  start_server_success,
  stop_server_inprogress,
  stop_server_failure,
  stop_server_success,
}

class HomeState {
  HomeState({
    this.status = HomeStatus.initial,
    this.servers = const [],
  });

  final HomeStatus status;
  final List<ServerModel> servers;

  List<ServerModel> get activeServers => servers.where((element) => element.isActive).toList();
  List<ServerModel> get inActiveServers => servers.where((element) => !element.isActive).toList();

  bool get isLoading => [
        HomeStatus.checking_health,
        HomeStatus.start_server_inprogress,
        HomeStatus.stop_server_inprogress
      ].contains(status);

  String? get loadingMessage {
    if (status == HomeStatus.start_server_inprogress) {
      return 'Starting';
    }
    if (status == HomeStatus.stop_server_inprogress) {
      return 'Stopping';
    }
    return null;
  }

  HomeState copyWith({
    HomeStatus? status,
    List<ServerModel>? servers,
  }) {
    return HomeState(
      status: status ?? this.status,
      servers: servers ?? this.servers,
    );
  }
}
