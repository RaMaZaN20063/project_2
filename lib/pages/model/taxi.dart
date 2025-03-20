class CompletedRide {
  final String driverName;
  final String carNumber;
  final String? arrivalTime;
  final String driverImageUrl;

  CompletedRide({
    required this.driverName,
    required this.carNumber,
    this.arrivalTime,
    required this.driverImageUrl,
  });
}