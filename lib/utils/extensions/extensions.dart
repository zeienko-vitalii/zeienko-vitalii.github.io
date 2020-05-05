extension kotlinExtensions on Object {
  void let(Function(Object obj) callback) {
    callback(this);
  }
}
