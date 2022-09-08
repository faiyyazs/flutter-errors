extension Ext on Object? {
  ifNotNull(Function() action) {
    if (this != null) {
      action();
    }
    return this;
  }
}
