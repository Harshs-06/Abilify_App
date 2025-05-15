import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MapUtils {
  static Future<BitmapDescriptor> getMarkerIcon(String path, int width) async {
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(width.toDouble(), width.toDouble())),
      path,
    );
  }

  static BitmapDescriptor getDefaultIcon(Color color) {
    return BitmapDescriptor.defaultMarkerWithHue(
      color == Colors.blue 
        ? BitmapDescriptor.hueBlue 
        : color == Colors.green 
          ? BitmapDescriptor.hueGreen
          : color == Colors.yellow 
            ? BitmapDescriptor.hueYellow
            : BitmapDescriptor.hueViolet
    );
  }
  
  static List<Marker> getTherapistMarkers() {
    // Sample data for therapists
    return [
      Marker(
        markerId: MarkerId('therapist1'),
        position: LatLng(37.7749, -122.4194),
        infoWindow: InfoWindow(
          title: 'Dr. Sarah Johnson',
          snippet: 'Speech Therapy • 4.9 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('therapist2'),
        position: LatLng(37.7739, -122.4312),
        infoWindow: InfoWindow(
          title: 'Dr. Michael Chen',
          snippet: 'Occupational Therapy • 4.8 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('therapist3'),
        position: LatLng(37.7819, -122.4159),
        infoWindow: InfoWindow(
          title: 'Dr. Emily Williams',
          snippet: 'Behavioral Therapy • 4.7 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('therapist4'),
        position: LatLng(37.7899, -122.4094),
        infoWindow: InfoWindow(
          title: 'Dr. James Wilson',
          snippet: 'Child Psychology • 4.9 ★',
        ),
      ),
    ];
  }
  
  static List<Marker> getMedicalMarkers() {
    // Sample data for medical facilities
    return [
      Marker(
        markerId: MarkerId('medical1'),
        position: LatLng(37.7849, -122.4294),
        infoWindow: InfoWindow(
          title: 'Children\'s Wellness Center',
          snippet: 'Special Needs & Development • 0.8 miles',
        ),
      ),
      Marker(
        markerId: MarkerId('medical2'),
        position: LatLng(37.7749, -122.4294),
        infoWindow: InfoWindow(
          title: 'Sunshine Pediatric Clinic',
          snippet: 'Child Neurology, Pediatrics • 1.2 miles',
        ),
      ),
      Marker(
        markerId: MarkerId('medical3'),
        position: LatLng(37.7649, -122.4154),
        infoWindow: InfoWindow(
          title: 'Hope Development Center',
          snippet: 'Developmental Medicine • 2.4 miles',
        ),
      ),
    ];
  }
  
  static List<Marker> getSchoolMarkers() {
    // Sample data for schools
    return [
      Marker(
        markerId: MarkerId('school1'),
        position: LatLng(37.7649, -122.4394),
        infoWindow: InfoWindow(
          title: 'Bright Stars Academy',
          snippet: 'Special Education • 1.5 miles • 4.8 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('school2'),
        position: LatLng(37.7579, -122.4294),
        infoWindow: InfoWindow(
          title: 'Inclusive Learning Center',
          snippet: 'Inclusive School • 2.3 miles • 4.9 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('school3'),
        position: LatLng(37.7529, -122.4154),
        infoWindow: InfoWindow(
          title: 'Rainbow Kids School',
          snippet: 'Specialized Programs • 3.1 miles • 4.7 ★',
        ),
      ),
    ];
  }
  
  static List<Marker> getCaregiverMarkers() {
    // Sample data for caregivers
    return [
      Marker(
        markerId: MarkerId('care1'),
        position: LatLng(37.7949, -122.4094),
        infoWindow: InfoWindow(
          title: 'Maria Garcia',
          snippet: 'Special Needs Nanny • 4.9 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('care2'),
        position: LatLng(37.7749, -122.4024),
        infoWindow: InfoWindow(
          title: 'David Lee',
          snippet: 'Respite Care Provider • 4.8 ★',
        ),
      ),
      Marker(
        markerId: MarkerId('care3'),
        position: LatLng(37.7849, -122.4154),
        infoWindow: InfoWindow(
          title: 'Sophie Miller',
          snippet: 'ABA Therapist & Caregiver • 4.9 ★',
        ),
      ),
    ];
  }
  
  static CameraPosition getDefaultCameraPosition() {
    return CameraPosition(
      target: LatLng(37.7749, -122.4194), // San Francisco coordinates
      zoom: 12.0,
    );
  }
} 