//
//  ViewController.swift
//  PlaceholderCarthageExample
//
//  Created by Oleksii Horishnii on 5/4/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import Placeholders

class ViewController: UIViewController {

    @IBOutlet weak var placeholder: PlaceholderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect.zero)
        label.text = "Placeholder carthage example"
        self.placeholder.insertedView = label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

