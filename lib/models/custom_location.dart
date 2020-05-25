class CustomLocation {
  List<double> getLocation(String latitude, String longitude) {
    if (latitude.toLowerCase().contains('n/a') ||
        longitude.toLowerCase().contains('n/a')) return null;

    double convertedLat = 0.0, convertedLon = 0.0;
    try {
      var expression = RegExp(r'\d+(?:\.\d+)?', caseSensitive: false);
      //Convert latitude first
      List<double> values = expression
          .allMatches(latitude)
          .map((e) => double.parse(e[0]))
          .toList();

      convertedLat = getOperator(latitude) *
          (values[0] +
              (values[1] == 0 ? 0 : values[1] / 60) +
              (values[2] == 0 ? 0 : values[2] / 3600));

      //convert longitude
      values = expression
          .allMatches(longitude)
          .map((e) => double.parse(e[0]))
          .toList();

      convertedLon = (values[0] +
              (values[1] == 0 ? 0 : values[1] / 60) +
              (values[2] == 0 ? 0 : values[2] / 3600)) *
          getOperator(longitude);

      return [convertedLat, convertedLon];
    } catch (ignore) {
      return null;
    }
  }

  int getOperator(String value) {
    String v = value.toLowerCase();
    if (v.contains('n') || v.contains('e'))
      return 1;
    else
      return -1;
  }
}
