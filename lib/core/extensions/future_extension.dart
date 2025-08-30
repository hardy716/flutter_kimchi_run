import 'dart:async';

extension ApiExtension<T> on Future<T> {
  Future<T> throwIfTimeOut({
    Duration? timeout,
    String? timeoutMessage,
  }) {
    final duration = timeout ?? const Duration(seconds: 30);
    return this.timeout(
      duration,
      onTimeout: () => throw TimeoutException(timeoutMessage),
    );
  }
}