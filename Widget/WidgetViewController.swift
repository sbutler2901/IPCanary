//
//  WidgetViewController.swift
//  Widget
//
//  Created by Seth Butler on 12/28/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import UIKit
import NotificationCenter
import IPCanary

class WidgetViewController: UIViewController, NCWidgetProviding/*, ViewModelUpdatable*/ {
    
    @IBOutlet var currentIPLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var ipLastUpdateLabel: UILabel!
    @IBOutlet var ipLastChangedLabel: UILabel!
    
//    func viewModelDidUpdate() {
//        currentIPLabel.text = mainViewModel.currentIP
//        cityLabel.text = mainViewModel.city
//        countryLabel.text = mainViewModel.country
//        hostnameLabel.text = mainViewModel.hostname
//        ipLastUpdateLabel.text = mainViewModel.ipLastUpdate
//        ipLastChangedLabel.text = mainViewModel.ipLastChanged
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        //print("viewLoaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        //test = NetworkManager()
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
