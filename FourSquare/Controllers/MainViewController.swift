//
//  MainViewController.swift
//  FourSquare
//
//  Created by Kimball Yang on 11/12/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {

    
    //MARK: Outlets
    
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var daCollection: UICollectionView!
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var daMap: MKMapView!
    
    private let locationManager = CLLocationManager()

    let initialLocation = CLLocation(latitude: 40.742054, longitude: -73.769417)
    let searchRadius: CLLocationDistance = 2000
    var annotations = [MKAnnotation]()
    
    
    //MARK: Actions
    
    @IBAction func listButtonPressed(_ sender: Any) {
        print("button tapped")
    }
    
    var locations = [Location](){
        didSet{
            daCollection.reloadData()
            locations.forEach { (location) in
                let annotation = MKPointAnnotation()
                annotation.title = location.name
                annotation.coordinate = location.coordinate
                annotations.append(annotation)
                daMap.addAnnotation(annotation)
            }
            self.daMap.showAnnotations(self.annotations, animated: true)
        }
    }
    
    var searchString: String? = nil {
        didSet{
            daMap.addAnnotations(locations.filter{ $0.hasValidCoordinates})
        }
    }
    
    
    private func locationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            daMap.showsUserLocation = true
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            locationManager.requestWhenInUseAuthorization()
            
        }
    }
    
    //MARK: Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        daMap.delegate = self
    }
    
    

}

    //MARK: Extensions

extension MainViewController: MKMapViewDelegate {
    
    
    
    
}


    //MARK: SearchBar delegates
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchField.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchField.showsCancelButton = false
        searchField.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         //create activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        
        //search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            
            if response == nil {
                print(error!)
            } else {
                //remove annotations
                let annotations = self.daMap.annotations
                self.daMap.removeAnnotations(annotations)
                
                //get data
                let latitud = response?.boundingRegion.center.latitude
                let longitud = response?.boundingRegion.center.longitude
                
                let newAnnotation = MKPointAnnotation()
                newAnnotation.title = searchBar.text
                newAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitud!, longitude: longitud!)
                self.daMap.addAnnotation(newAnnotation)
                
                //to zoom in the annotation
                let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 2.0, longitudinalMeters: self.searchRadius * 2.0)
                self.daMap.setRegion(coordinateRegion, animated: true)
            }
        }

    }
    
}


