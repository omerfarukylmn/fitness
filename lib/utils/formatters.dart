String formatDuration(Duration duration) {
  String ikiBasamak(int n) => n.toString().padLeft(2, '0');
  String ikiBasamakDakika = ikiBasamak(duration.inMinutes.remainder(60));
  String ikiBasamakSaniye = ikiBasamak(duration.inSeconds.remainder(60));
  return "${ikiBasamak(duration.inHours)}:$ikiBasamakDakika:$ikiBasamakSaniye";
  
}
String formatDuration1(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
