//
//  MainViewController.swift
//  IPCanary
//
//  Created by Seth Butler on 12/15/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , ViewModelUpdatable {

    // MARK: - IBOutlets
    
    @IBOutlet var currentIPLabel: UILabel!
    @IBOutlet var ipLastUpdateLabel: UILabel!
    @IBOutlet var ipLastChangedLabel: UILabel!

    // MARK: - IBActions
    
    @IBAction func refreshPressed(_ sender: Any) {
        mainViewModel.refreshIP()
    }
    
    // MARK: - Class Variables
    
    private let mainViewModel: MainViewModel
    
    // MARK: - View Controller Methods
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func viewModelDidUpdate() {
        currentIPLabel.text = mainViewModel.currentIP
        ipLastUpdateLabel.text = mainViewModel.ipLastUpdate
        ipLastChangedLabel.text = mainViewModel.ipLastChanged
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelDidUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainViewModel.refreshIP()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

