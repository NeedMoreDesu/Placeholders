//
//  ViewController.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class MyTableContents: TableContents {
    func sections() -> Int {
        return 1
    }

    func rows(section: Int) -> Int {
        return 13
    }

    func generator(path: IndexPath) -> TableViewCellGenerator {
        let viewGenerator = CellGenerator.View(create: { () -> UILabel in
            return UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        }, update: { (label: UILabel, vc: UIViewController) -> () in
            label.text = "tratata"
        })
        return viewGenerator
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var containerView: ContainerView!
    var tableVC: VCSTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let v1 = CellGenerator.View(create: { () -> UILabel in
//            return UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        }, update: { (label: UILabel, vc: UIViewController) -> () in
//            label.text = "tratata"
//        })
//
//        let arr: [TableViewCellGenerator] = [v1, v1, v1, v1]
        
        self.tableVC = VCSTableVC.create(builderFn: { (vc) in
            vc.tableContents = MyTableContents()
        })
        self.containerView.insertedView = self.tableVC
    }
}

