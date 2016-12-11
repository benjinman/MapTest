import UIKit
import GoogleMaps

class ViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    var mapView: GMSMapView!
    
    @IBOutlet weak var transition: UIButton!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.view.addSubview(mapView)
        transition.layer.zPosition = 1
    }
    
    override func loadView() {
        super.loadView()
        mapView = GMSMapView.map(withFrame: .init(x: 50, y: 50, width: 200, height: 400), camera: GMSCameraPosition.camera(withLatitude: 1.285,
                                                                          longitude: 103.848,
                                                                          zoom: 12))
        let testView = GMSMapView.map(withFrame: .init(x: 50, y: 50, width: 200, height: 400), camera: GMSCameraPosition.camera(withLatitude: 1.285,
                                                                                                                          longitude: 103.848,
                                                                                                                          zoom: 12))
        //self.view = mapView
        //self.view.addSubview(testView)
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude:(location?.coordinate.longitude)!, zoom:14)
        mapView.animate(to: camera)
        
        let currentPosition = GMSMarker(position: .init(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!))
        currentPosition.map = mapView
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }
}
