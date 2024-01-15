extension IntExt on int {
  int ifEmpty(int value) {
    return this == 0 ? value : this;
  }
}
