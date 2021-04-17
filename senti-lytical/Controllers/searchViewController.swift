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
        
        startAnimation()
        
        return true
    }
    
    fileprivate func startAnimation(){
        
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: .darkGray, padding: 0)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        loading.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            
            loading.stopAnimating()
        }
    }
    
    
    
    


}
