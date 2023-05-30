extension StringCasingExtension on String? {
  String toCapitalized() => (this != null && this!.length > 0)?'${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}':'';
  String toTitleCase() => this == null ? "" : this!.replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}