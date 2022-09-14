extension Ext on Object? {
  dynamic ifNotNull(Function() action) {
    if (this != null) {
      action();
    }
    return this;
  }
}
