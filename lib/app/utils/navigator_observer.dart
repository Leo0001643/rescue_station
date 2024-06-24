import 'package:flutter/cupertino.dart';
class CustomNavigatorObserver extends NavigatorObserver {
  bool _isLocked = false;

  @override
  void didPush(Route route, Route? previousRoute) {
    _isLocked = true;
    super.didPush(route, previousRoute);
    _isLocked = false;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _isLocked = true;
    super.didPop(route, previousRoute);
    _isLocked = false;
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _isLocked = true;
    super.didRemove(route, previousRoute);
    _isLocked = false;
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _isLocked = true;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _isLocked = false;
  }

  bool get isLocked => _isLocked;
}
