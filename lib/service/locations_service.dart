
import '../dummy_data/dummy_data.dart';
import '../model/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {

  static const List<Location> availableLocations = fakeLocations;   // TODO for now fake data

  static List<Location> searchLocations(String query){
    return availableLocations.where((location) => location.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}