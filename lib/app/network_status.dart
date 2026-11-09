import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _probeTimeout = Duration(seconds: 3);
const _retryInterval = Duration(seconds: 30);
final _probeUri = Uri.https('connectivitycheck.gstatic.com', '/generate_204');

final networkOnlineProvider = StreamProvider.autoDispose<bool>(
  (ref) => _watchNetwork(Connectivity()),
);

Stream<bool> _watchNetwork(Connectivity connectivity) => Stream.multi((sink) {
  var active = true;
  var generation = 0;
  bool? online;

  Future<void> check([List<ConnectivityResult>? transports]) async {
    final request = ++generation;
    final available = transports ?? await _readTransports(connectivity);
    final reachable =
        available.any((transport) => transport != ConnectivityResult.none) &&
        await _isReachable();
    if (!active || request != generation || reachable == online) return;
    online = reachable;
    sink.add(reachable);
  }

  final subscription = connectivity.onConnectivityChanged.listen(
    (transports) => unawaited(check(transports)),
    onError: sink.addError,
  );
  final retry = Timer.periodic(_retryInterval, (_) {
    if (online != true) unawaited(check());
  });
  sink.onCancel = () async {
    active = false;
    retry.cancel();
    await subscription.cancel();
  };
  unawaited(check());
});

Future<List<ConnectivityResult>> _readTransports(
  Connectivity connectivity,
) async {
  try {
    return await connectivity.checkConnectivity();
  } on Exception {
    return const [ConnectivityResult.none];
  }
}

Future<bool> _isReachable() async {
  final client = HttpClient()..connectionTimeout = _probeTimeout;
  try {
    return await (() async {
      final request = await client.getUrl(_probeUri);
      request.followRedirects = false;
      final response = await request.close();
      return response.statusCode == HttpStatus.noContent;
    })().timeout(_probeTimeout);
  } on Exception {
    return false;
  } finally {
    client.close(force: true);
  }
}
