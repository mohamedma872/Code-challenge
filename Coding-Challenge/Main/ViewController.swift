//
//  ViewController.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 04/09/2021.
//

import UIKit

class ViewController: UIViewController,Storyboarded  {
    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Home"
    }

    @IBAction func startListClicked(_ sender: UIButton) {
        coordinator?.NavigateToTaxiList()
        
    }
    @IBAction func startMapClicked(_ sender: UIButton) {
        coordinator?.NavigateToTaxiMap()
        
    }
}

