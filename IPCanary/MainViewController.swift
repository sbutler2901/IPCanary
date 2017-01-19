//
//  MainViewController.swift
//  IPCanary
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController, ViewModelUpdatable {
    
    // MARK: - Class Variables
    
    private let mainViewModel: MainViewModel
    
    // MARK: - IBOutlets
    
    @IBOutlet var currentIPLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var hostnameLabel: UILabel!
    @IBOutlet var ipLastUpdateLabel: UILabel!
    @IBOutlet var ipLastChangedLabel: UILabel!
    @IBOutlet var refreshBtn: UIButton!

    // MARK: - IBActions
    
    @IBAction func refreshPressed(_ sender: Any) {
        mainViewModel.refreshIP()
    }
    
    @IBAction func loadSettings(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let settingsViewModel: SettingsViewModel = SettingsViewModel(networkManager: appDelegate.networkManager)
        let settingsViewController = SettingsViewController(settingsViewModel: settingsViewModel)
        navigationController?.pushViewController(settingsViewController, animated: false)
    }
    
    // MARK: - MVVM Functions
    
    func viewModelDidUpdate() {
        currentIPLabel.text = mainViewModel.currentIP
        cityLabel.text = mainViewModel.city
        countryLabel.text = mainViewModel.country
        hostnameLabel.text = mainViewModel.hostname
        ipLastUpdateLabel.text = mainViewModel.ipLastUpdate
        ipLastChangedLabel.text = mainViewModel.ipLastChanged
    }
    
    // MARK: - View Controller Methods
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: "MainView", bundle: nil)
        self.mainViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelDidUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //mainViewModel.refreshIP()
        refreshBtn.layer.cornerRadius = 7.0
        refreshBtn.layer.borderWidth = 1
        refreshBtn.layer.borderColor = UIColor.white.cgColor
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: String("\u{2699}"), style: .plain, target: self, action: #selector(loadSettings(sender:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

