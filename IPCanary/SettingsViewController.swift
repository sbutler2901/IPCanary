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
    
    @IBOutlet var queryHostTextField: UITextField!
    
    // MARK: - IBActions
    
    // MARK: - MVVM Functions
    
    func viewModelDidUpdate() {
        queryHostTextField.text = settingsViewModel.host
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelDidUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        
        if parent == nil {
            settingsViewModel.hostChanged(host: queryHostTextField.text!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
