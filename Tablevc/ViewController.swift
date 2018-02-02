//
//  ViewController.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: ContainerView!
    var tableVC: VCSTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableVC = VCSTableVC.create(builderFn: { (vc) in
            let viewGenerator = CellGenerator.View(create: { () -> UILabel in
                return UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            }, update: { (label: UILabel, vc: UIViewController) -> () in
                label.text = "tratata"
            })

            vc.tableContents = //TableContents.fromArray(array1d: [viewGenerator])
                RowsProvider(sections: { () -> Int in
                return 1
            }, rows: { (section) -> Int in
                return 13
            }, generator: { (indexPath: IndexPath) -> TableViewCellGenerator in
                return viewGenerator
            })
        })
        self.containerView.insertedView = self.tableVC
    }
}

