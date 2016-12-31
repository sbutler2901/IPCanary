//
//  IPCanaryWidgetViewController.swift
//  IPCanaryWidget
//
//  Created by Seth Butler on 12/28/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import UIKit
import NotificationCenter
import IPCanaryKit

class IPCanaryWidgetViewController: UIViewController, NCWidgetProviding, ViewModelUpdatable {
    
    @IBOutlet var currentIPLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var ipLastUpdateLabel: UILabel!
    @IBOutlet var ipLastChangedLabel: UILabel!
    
    private let widgetViewModel: IPCanaryWidgetViewModel
    
    required init?(coder aDecoder: NSCoder) {
        widgetViewModel = IPCanaryWidgetViewModel(networkManager: NetworkManager(withAutoRefresh: false))
        super.init(coder: aDecoder)
        self.widgetViewModel.delegate = self
    }
    
    func viewModelDidUpdate() {
        currentIPLabel.text = widgetViewModel.currentIP
        cityLabel.text = widgetViewModel.city
        countryLabel.text = widgetViewModel.country
        ipLastUpdateLabel.text = widgetViewModel.ipLastUpdate
        ipLastChangedLabel.text = widgetViewModel.ipLastChanged
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelDidUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
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
        
        widgetViewModel.refreshIP()
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
