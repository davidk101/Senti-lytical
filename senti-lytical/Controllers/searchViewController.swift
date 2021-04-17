//
//  searchViewController.swift
//  senti-lytical
//
//  Created by David Kumar on 4/17/21.
//  Copyright © 2021 David Kumar. All rights reserved.
//

import UIKit
import TextFieldEffects
import NVActivityIndicatorView

class searchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchField: KaedeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        print(searchField.text!)
        
        return true
    }
    
    
    
    


}
