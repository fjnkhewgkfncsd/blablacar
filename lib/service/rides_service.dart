import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';
import '../utils/date_time_utils.dart';

class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  //
  //  filter the rides starting from given departure location
  //
  static List<Ride> _filterByDeparture(Location departure, List<Ride> rides) {
    return rides
        .where(
          (ride) =>
              ride.departureLocation == departure &&
              DateTimeUtils.comparedDate(ride.departureDate),
        )
        .toList();
  }

  //
  //  filter the rides starting for the given requested seat number
  //
  static List<Ride> _filterBySeatRequested(
    int requestedSeat,
    List<Ride> rides,
  ) {
    return rides
        .where(
          (ride) =>
              ride.availableSeats >= requestedSeat &&
              DateTimeUtils.comparedDate(ride.departureDate),
        )
        .toList();
  }

  //
  //  filter the rides   with several optional criteria (flexible filter options)
  //
  static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    if (departure == null && seatRequested == null) {
      return availableRides;
    } else if (departure != null && seatRequested == null) {
      return _filterByDeparture(departure, availableRides);
    } else if (departure == null && seatRequested != null) {
      return _filterBySeatRequested(seatRequested, availableRides);
    } else {
      return availableRides
          .where(
            (ride) =>
                ride.departureLocation == departure &&
                ride.availableSeats >= seatRequested! &&
                DateTimeUtils.comparedDate(ride.departureDate)
          )
          .toList();
    }
  }
}
