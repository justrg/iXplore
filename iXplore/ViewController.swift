//
//  ViewController.swift
//  SpotListDemo
//
//  Created by Justin on 6/8/16.
//  Copyright © 2016 Justin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var spotList = Spot.spotList()
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupMapView()
        setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupMapView() {
        mapView.mapType = .Hybrid
        self.mapView.showsBuildings = true
        //self.mapView.addAnnotation(self.spotList as! MKAnnotation)
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.registerNib(nibName: "SpotTableViewCell", bundle: nil), forCellReuseIdentifier: "spotTableViewCell")
    }
    
    
    ////////// TABLE VIEW FUNCTIONS /////////////////
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spotList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let spot = spotList[indexPath.row]
        
        if spot.ratable {
            let cell = tableView.dequeueReusableCellWithIdentifier("spotList") as! SpotTableViewCell
            cell.cellImage.imagefromUrl(spot.logoURL)
            cell.label.text = spot.title
            return cell
        }
        else{
            let cell = UITableViewCell
            
            let logoImage = UIImageView(frame: CGRectMake(0, 0, 44, 44))
            logoImage.imageFromUrl(spot.logoURL!)
        }
//        let cell = tableView.dequeueReusableCellWithIdentifier("spotList")
//        
//        if cell == nil {
//            let cell = tableView.dequeueReusableCellWithIdentifier("spotList")
        }
//        let cell = UITableViewCell()
//        cell.textLabel?.text = spot.title
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let spot = spotList[indexPath.row]
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let mapCenterCoordinateAfterMove = CLLocationCoordinate2D(latitude: spot.coordinate.latitude, longitude: spot.coordinate.longitude)
        self.mapView.addAnnotation(spot as! MKAnnotation)
        
        var span = MKCoordinateSpanMake(0.01, 0.01)
        var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: mapCenterCoordinateAfterMove.latitude, longitude: mapCenterCoordinateAfterMove.longitude), span: span)
        mapView.setRegion(region, animated: true)
        
        
//        self.mapView.centerCoordinate = mapCenterCoordinateAfterMove
//        
//        mapView.region.center.latitude = spot.coordinate.latitude
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let spot = spotList[indexPath.row]
        
        let roe = indexPath.row
        print ()
        if spot.ratable{
            return 88
        }
        else{
            
        return 44
        }
    }
    
}

