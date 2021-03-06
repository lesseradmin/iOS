//
//  MapViewIndoorMapsTableViewController.swift
//  hackillinois-2017-ios
//
//  Created by Derek Leung on 2017/2/14.
//  Copyright © 2017年 Shotaro Ikeda. All rights reserved.
//

import UIKit

class MapViewIndoorMapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Global Variables
    var location_id = 1
    var location_names = [Int: String]()
    var images = [UIImage]()
    
    // MARK: UIViewController Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location_names[1] = "DCL"
        location_names[2] = "Siebel"
        location_names[3] = "ECEB"
        location_names[4] = "Union"
        location_names[5] = "Kenny Gym Annex"
        
        self.navigationItem.hidesBackButton = false
        if let name = location_names[location_id] {
            self.title = name
        }
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        images = items.filter { return $0.hasPrefix("indoor_\(location_id)")
        }.sorted { return $0 < $1
        }.map { return UIImage(named: $0)!
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath)

        cell.backgroundColor = UIColor.clear
        
        let image = images[indexPath.row]
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = image
        
        imageView.constraints.filter { (constraint) -> Bool in
            return constraint.identifier == "ratio"
        }.first?.constant = image.size.width / image.size.height
        
        imageView.updateConstraints()
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
