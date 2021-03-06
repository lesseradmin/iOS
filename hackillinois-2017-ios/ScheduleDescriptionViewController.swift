//
//  ScheduleDescriptionViewController.swift
//  hackillinois-2017-ios
//
//  Created by Derek Leung on 2017/2/8.
//  Copyright © 2017年 Shotaro Ikeda. All rights reserved.
//

import UIKit

class ScheduleDescriptionViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageAspectRatio: NSLayoutConstraint!
    
    var dayItem: DayItem?
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up back button
        self.navigationController?.navigationBar.tintColor = UIColor(red: 93.0/255.0, green: 200.0/255.0, blue: 219.9/255.0, alpha: 1.0)

        // Init content
        timeLabel.text = dayItem?.time
        titleLabel.text = dayItem?.name
        locationLabel.text = dayItem?.locations.map { $0.location_name }.joined(separator: "\n")
        descriptionLabel.text = dayItem?.descriptionStr
        
        if let imageUrl = dayItem?.imageUrl {
            // load image in background thread
            performSelector(inBackground: #selector(loadImage), with: imageUrl)
        } else if let imageFileName = dayItem?.imageFileName {
            // load image by data
            if let image = UIImage(named: imageFileName) {
                setImage(imageData: UIImagePNGRepresentation(image)!)
            }
        }
    }
    
    func loadImage(imageUrl: String) {
        let data = NSData(contentsOf: NSURL(string: imageUrl)! as URL)
        if let data = data {
            performSelector(onMainThread: #selector(setImage), with: data as Data, waitUntilDone: false)
        }
    }
    
    func setImage(imageData: Data) {
        self.imageData = imageData as Data
        
        let dummyImage = UIImage(data: imageData)
        let dummyWidth = dummyImage?.size.width
        let dummyHeight = dummyImage?.size.height
        image.image = dummyImage
        image.isUserInteractionEnabled = true
        
        //self.view.layoutIfNeeded()
        //imageHeight.constant = (image.frame.width) / dummyWidth! * dummyHeight!
        imageAspectRatio.constant = dummyWidth! / dummyHeight!
        image.updateConstraints()
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ScheduleDescriptionImageView") as? ScheduleDetailsImageViewController {
            vc.imageData = imageData
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
