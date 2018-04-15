//
//  ViewController.swift
//  Tablevc
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: PlaceholderView!
    var tableVC: VCSTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableVC = VCSTableVC.create(builderFn: { (vc) in
            let dataRows = RowsProvider(sections: { () -> Int in
                return 5
            }, rows: { (section) -> Int in
                return 40
            }, item: { (indexPath: IndexPath) -> String in
                return "row: \(indexPath.row); section: \(indexPath.section);"
            })
            
            let generatorRows = dataRows.map(transform: { (title: String) -> TableViewCellGenerator in
                return CellGenerator.View(create: { () -> UILabel in
                    return UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                }, update: { (label: UILabel, vc: UIViewController) -> () in
                    label.text = title
                })
            })
            
            vc.rowsProvider = generatorRows
                
            vc.sectionsHeaderProvider = SectionsProvider(section: { (section: Int) -> UILabel in
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                label.text = "section \(section)"
                label.backgroundColor = UIColor(red: 220/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1.0)
                return label
            })
        })
        
        self.containerView.insertedView = self.tableVC
        
        ContainersUtils.afterDelay(seconds: 1.0) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            label.text = "I'll remove myself in 3 second"
            let popup = label.showPopup()
            ContainersUtils.afterDelay(seconds: 3.0, fn: {
                popup.dismissPopup()
            })
        }
    }
}

