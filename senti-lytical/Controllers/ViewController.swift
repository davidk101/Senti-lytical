//
//  ViewController.swift
//  senti-lytical
//
//  Created by David Kumar on 4/17/21.
//  Copyright © 2021 David Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func typeButton(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "search_vc") as? searchViewController
            else{
                return 
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func scanButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

