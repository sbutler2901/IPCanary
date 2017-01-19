//
//  SettingsViewController.swift
//  IPCanary
//
//  Created by Seth Butler on 1/18/17.
//  Copyright © 2017 SBSoftware. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, ViewModelUpdatable {
    
    // MARK: - Class Variables
    
    private let settingsViewModel: SettingsViewModel
    
    // MARK: - IBOutlets
    
//    @IBOutlet var currentIPLabel: UILabel!
//    @IBOutlet var cityLabel: UILabel!
//    @IBOutlet var countryLabel: UILabel!
//    @IBOutlet var hostnameLabel: UILabel!
//    @IBOutlet var ipLastUpdateLabel: UILabel!
//    @IBOutlet var ipLastChangedLabel: UILabel!
//    @IBOutlet var refreshBtn: UIButton!
    
    // MARK: - IBActions
    
    // MARK: - MVVM Functions
    
    func viewModelDidUpdate() {
//        currentIPLabel.text = mainViewModel.currentIP
//        cityLabel.text = mainViewModel.city
//        countryLabel.text = mainViewModel.country
//        hostnameLabel.text = mainViewModel.hostname
//        ipLastUpdateLabel.text = mainViewModel.ipLastUpdate
//        ipLastChangedLabel.text = mainViewModel.ipLastChanged
    }
    
    // MARK: - View Controller Methods
    
    init(settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
        super.init(nibName: "SettingsView", bundle: nil)
        self.settingsViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        viewModelDidUpdate()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
