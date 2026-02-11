import 'package:flutter/material.dart';
import '../../model/ride/locations.dart';
import '../../ui/theme/theme.dart';
import '../../ui/widgets/inputs/bla_text_field.dart';
import '../../service/locations_service.dart';
import './widgets/location_tile.dart';
import '../../ui/widgets/display/bla_divider.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? location;
  final List<Location> historyLocations ;
  const BlaLocationPicker({super.key, this.location, this.historyLocations = const []});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  final TextEditingController _controller = TextEditingController();

  @override 
  void initState() {
    super.initState();
    if(widget.location != null){
      _controller.text = widget.location!.name;
    }

    _controller.addListener(() {
      setState(() {});
    });
  }

  void onArrowback(BuildContext context){
    Navigator.pop(context, widget.location);
  }

  bool isClearButtonVisible(){
    return _controller.text.isNotEmpty;
  }

  void onTapLocation(Location location){
    Navigator.pop(context, location);
  }


  void onClear(){
    _controller.clear();
  }

  List<Location> get filteredLocations{
    if(_controller.text.trim().isEmpty){
      return [];
    }
    return LocationsService.searchLocations(_controller.text);
  } 
  
  @override 
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children : [
            Container(
              decoration: BoxDecoration(
                color: BlaColors.backgroundTextEditing,
                borderRadius: BorderRadius.circular(BlaSpacings.s),
              ),
              child: ListTile(
                leading: IconButton(
                  onPressed: () => onArrowback(context),
                  icon: Icon(Icons.arrow_back_ios)
                ),
                title: BlaTextEditing(controller: _controller),
                trailing: isClearButtonVisible()
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: onClear,
                      )
                    : null,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  final location = filteredLocations[index];
                  return Column(
                    children: [
                      BlaLocationTile(
                        location: location,
                        onTap: () => onTapLocation(location),
                      ),
                      BlaDivider()
                    ],
                  );
                },
              )
            )
          ]
        )
      )
    );
  }
}