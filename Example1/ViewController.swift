//
//  ViewController.swift
//  Example1
//
//  Created by Oleksii Horishnii on 1/26/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import Placeholders

class ViewController: UIViewController {
    @IBOutlet weak var containerView: PlaceholderView!
    var tableVC: PlaceholderTableVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableVC = PlaceholderTableVC.create()
        
        let dataRows = RowsProvider(sections: { () -> Int in
            return 5
        }, rows: { (section) -> Int in
            return 40
        }, item: { (indexPath: IndexPath) -> String in
            return "row: \(indexPath.row); section: \(indexPath.section);"
        })
        
        let generatorRows = dataRows.map(transform: { (title: String) -> CellGenerator in
            return CellGenerator(create: .generator({ () -> UILabel in
                return UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            }), update: { (label: UILabel, vc: UIViewController) -> () in
                label.text = title
            })
        })
        
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        topLabel.text = "Cell that I want to add on top"
        
        let finalRows = topLabel.toCellGenerator().toSingleItemRowsProvider() + generatorRows
        
        self.tableVC.rowsProvider = finalRows
        
        self.tableVC.sectionsHeaderProvider = SectionsProvider(section: { (section: Int) -> UILabel? in
            if (section == 0) {
                return nil
            }
            let section = section - 1
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            label.text = "section \(section)"
            label.backgroundColor = UIColor(red: 220/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1.0)
            return label
        })
        
        
        self.containerView.insertedView = self.tableVC
        
        PlaceholderUtils.afterDelay(seconds: 1.0) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
            label.text = "I'll remove myself in 3 second"
            let popup = label.showPopup()
            PlaceholderUtils.afterDelay(seconds: 3.0, fn: {
                popup.dismissPopup()
            })
        }
    }
}

