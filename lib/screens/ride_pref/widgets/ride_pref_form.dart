import 'package:flutter/material.dart';
 
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../../../utils/date_time_util.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/inputs/bla_location_picker.dart';
import '../../ride/rides_screen.dart';
import 'ride_pref_input_tile.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? _departureLocation;
  Location? _arrivalLocation;
  late DateTime _travelDate;
  late int _passengerCount;

  @override
  void initState() {
    super.initState();
    
    // Initialize with provided preferences or defaults
    if (widget.initRidePref != null) {
      _departureLocation = widget.initRidePref!.departure;
      _arrivalLocation = widget.initRidePref!.arrival;
      _travelDate = widget.initRidePref!.departureDate;
      _passengerCount = widget.initRidePref!.requestedSeats;
    } else {
      // Default values
      _departureLocation = null;
      _arrivalLocation = null; 
      _travelDate = DateTime.now();
      _passengerCount = 1;
    }
  }

  // Open location selection for departure
  Future<void> _selectDeparture() async {
    final selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: _departureLocation)
      )
    );
    
    if (selectedLocation != null) {
      setState(() => _departureLocation = selectedLocation);
    }
  }

  // Open location selection for arrival
  Future<void> _selectArrival() async {
    final selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        BlaLocationPicker(initLocation: _arrivalLocation)
      )
    );
    
    if (selectedLocation != null) {
      setState(() => _arrivalLocation = selectedLocation);
    }
  }

  // Switch departure and arrival locations
  void _swapLocations() {
    if (_departureLocation != null && _arrivalLocation != null) {
      setState(() {
        final temp = _departureLocation!;
        _departureLocation = Location.copy(_arrivalLocation!);
        _arrivalLocation = Location.copy(temp);
      });
    }
  }

  // Submit the form and navigate to results
  void _submitSearch() {
    if (_departureLocation != null && _arrivalLocation != null) {
      // Create ride preference from inputs
      final ridePref = RidePref(
        departure: _departureLocation!,
        departureDate: _travelDate, 
        arrival: _arrivalLocation!,
        requestedSeats: _passengerCount
      );
      
      // Navigate to results screen
      Navigator.of(context).push(
        AnimationUtils.createBottomToTopRoute(
          RidesScreen(initialRidePref: ridePref)
        )
      );
    }
  }

  // Display properties
  String get _departureText => 
      _departureLocation?.name ?? "Leaving from";
  
  String get _arrivalText => 
      _arrivalLocation?.name ?? "Going to";
  
  String get _dateText => 
      DateTimeUtils.formatDateTime(_travelDate);
  
  String get _passengersText => 
      _passengerCount.toString();
  
  bool get _showDeparturePlaceholder => 
      _departureLocation == null;
  
  bool get _showArrivalPlaceholder => 
      _arrivalLocation == null;
  
  bool get _canSwapLocations => 
      _departureLocation != null && _arrivalLocation != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              // Departure location input
              RidePrefInputTile(
                isPlaceHolder: _showDeparturePlaceholder,
                title: _departureText,
                leftIcon: Icons.location_on,
                onPressed: _selectDeparture,
                rightIcon: _canSwapLocations ? Icons.swap_vert : null,
                onRightIconPressed: _canSwapLocations ? _swapLocations : null,
              ),
              const BlaDivider(),
              
              // Arrival location input
              RidePrefInputTile(
                isPlaceHolder: _showArrivalPlaceholder,
                title: _arrivalText,
                leftIcon: Icons.location_on,
                onPressed: _selectArrival,
              ),
              const BlaDivider(),
              
              // Travel date input
              RidePrefInputTile(
                title: _dateText,
                leftIcon: Icons.calendar_month,
                onPressed: () {}, // Date selection would go here
              ),
              const BlaDivider(),
              
              // Passenger count input
              RidePrefInputTile(
                title: _passengersText,
                leftIcon: Icons.person_2_outlined,
                onPressed: () {}, // Passenger selection would go here
              ),
            ],
          ),
        ),
        
        // Search button
        BlaButton(
          text: 'Search', 
          onPressed: _submitSearch
        ),
      ],
    );
  }
}