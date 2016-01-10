//
//  LocalizacionViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 2/2/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
//  Uso de CoreLocation : http://nevan.net/2014/09/core-location-manager-changes-in-ios-8/


import UIKit
import MapKit

class LocalizacionViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    struct MainStoryboard {
        struct PinIdentifiers {
            static let pinMapa = "pinMapa"
        }
        
    }

    // MARK: - properties
    @IBOutlet weak var mapaMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    // MARK: - ciclo de vida del controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshLocation()
        cargarAnotaciones()
    }
    // MARK: - MKMapViewDelegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Anotacion {
            var pin : MKPinAnnotationView!
            
            if let pinMapa = mapaMapView.dequeueReusableAnnotationViewWithIdentifier(MainStoryboard.PinIdentifiers.pinMapa) {
                pin = pinMapa as! MKPinAnnotationView
                pin.annotation = annotation
            }
            else {
                pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: MainStoryboard.PinIdentifiers.pinMapa)
            }
            
            pin.pinColor = MKPinAnnotationColor.Red
            pin.canShowCallout = true
            pin.animatesDrop = false
            
            return pin
        }
        else {
            return nil
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let userLocation = MKCoordinateRegionMakeWithDistance(
            newLocation.coordinate,
            5000.0,5000.0)
        locationManager.stopUpdatingLocation()
        mapaMapView.setRegion(userLocation, animated: true)
    }
    // el usuario ha dado permiso para poder localizar
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways  ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ) {
                showLocation()
        }
        
    }
    // MARK: - funciones auxiliares
    private func refreshLocation() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways  ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ) {
            showLocation()
        }
        else {
            // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
            // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
            if locationManager.respondsToSelector("requestWhenInUseAuthorization"){
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    private func showLocation(){
        mapaMapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    private func cargarAnotaciones(){
        mapaMapView.addAnnotation(Anotacion(coordenada: CLLocationCoordinate2D(latitude: 40.40349, longitude: -3.71441)))
    }
    
    
}
