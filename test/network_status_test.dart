import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jdonuts_customer_app/app/network_status.dart';

class _ConnectedWifi implements Connectivity {
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => const [
    ConnectivityResult.wifi,
  ];

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      const Stream.empty();
}

void main() {
  test('detects internet loss and recovery on the same Wi-Fi', () async {
    final results = [true, false, true].iterator;
    final statuses = watchNetwork(
      _ConnectedWifi(),
      probe: () async {
        if (results.moveNext()) return results.current;
        return true;
      },
      interval: const Duration(milliseconds: 10),
    );

    await expectLater(
      statuses.take(3),
      emitsInOrder([true, false, true, emitsDone]),
    );
  });
}
