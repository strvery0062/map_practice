//
//  ViewController.swift
//  map
//
//  Created by Ryohei Sato on 2021/07/11.
//
// Ref. https://qiita.com/yuta-sasaki/items/797c74c64f57b36ddf29
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,
                      CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // require access to the location
        locManager = CLLocationManager()
        locManager.delegate = self
        
        // 位置情報の使用の許可を得る
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 座標の表示
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
        }
        
        initMap()
    }
    
    // get the location
    internal func locationManager(_ manager: CLLocationManager,
                                  didUpdateLocations locations:[CLLocation]) {
        let lonStr = (locations.last?.coordinate.longitude.description)!
        let latStr = (locations.last?.coordinate.latitude.description)!

        print("lon : " + lonStr)
        print("lat : " + latStr)
        
        updateCurrentPos((locations.last?.coordinate)!)
    }
    
    func initMap() {
        // set scale
        var region: MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region, animated: true)

        // 現在位置表示の有効化
        mapView.showsUserLocation = true
        //現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
        mapView.userTrackingMode = .follow
    }
    
    func updateCurrentPos(_ coordinate: CLLocationCoordinate2D) {
        var region:MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region, animated: true)
    }

}

