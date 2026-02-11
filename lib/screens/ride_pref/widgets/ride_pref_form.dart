import 'package:blabla/service/ride_prefs_service.dart';
import 'package:flutter/material.dart';
import 'pref_form_field.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../ui/widgets/display/bla_divider.dart';
import '../../../ui/widgets/actions/bla_button.dart';
import '../../../utils/date_time_utils.dart';
import '../../../dummy_data/dummy_data.dart';
import '../../../ui/theme/theme.dart';
import '../bla_location_picker.dart';
import '../../../service/locations_service.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if(widget.initRidePref != null){
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
    else{
      final now = DateTime.now();
      departureDate = DateTime(now.year, now.month, now.day);
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void toLocationPicker({required bool isDeparture,Location? location}) async{
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlaLocationPicker(location: location, historyLocations: LocationsService.availableLocations)
      )
    );
    if(result != null && result is Location){
      setState(() {
        if(isDeparture){
          departure = result;
        }
        else{
          arrival = result;
        }
      });
    }
  }

  void onDepartureTap(){
    toLocationPicker(isDeparture: true, location: departure);
  }

  void onArrivalTap(){
    toLocationPicker(isDeparture: false, location: arrival);
  }

  void onDateTap() async{
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Text('hello')
      )
    );
    if(result != null && result is DateTime){
      setState(() {
        departureDate = result;
      });
    }
  }

  void onSwapLocation(){
    setState((){
      var temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void onSeatsTap() async{
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Text('hello')
      )
    );
    if(result != null && result is int){
      setState(() {
        requestedSeats = result;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel => departure?.name ?? 'Leaving from'; 
  String get arrivalLabel => arrival?.name ?? 'Going to';

  void onSearch(){
    if(departure == null){
      onDepartureTap();
    }else if(arrival == null){
      onArrivalTap();
    }
    //to ride screen
  }

  bool isSwapVisible(){
    if(departure != null || arrival != null){
      return true;
    }
    return false;
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(BlaSpacings.radius),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.l),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [ 
                SizedBox(height: BlaSpacings.s),
                BlaPrefFormField(label: departureLabel, onTap: onDepartureTap,onTrailingTap: isSwapVisible() ? onSwapLocation : null),
                BlaDivider(),
                BlaPrefFormField(label: arrivalLabel, onTap: onArrivalTap),
                BlaDivider(),
                BlaPrefFormField(label: DateTimeUtils.formatDateTime(departureDate), onTap: onDateTap,icon:Icons.date_range_outlined),
                BlaDivider(),
                BlaPrefFormField(label:requestedSeats.toString(), onTap: onSeatsTap,icon:Icons.person_outline),
              ]
            ),
          ),
          BlaButton(label: 'Search', onPressed: onSearch, padding: BlaSpacings.l)
        ]
      ),
    );
  }
}
