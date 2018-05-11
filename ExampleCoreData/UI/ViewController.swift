//
//  ViewController.swift
//  ExampleCoreData
//
//  Created by Oleksii Horishnii on 5/8/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import UIKit
import Placeholders

protocol Presenter {
    var rows: RowsProvider<RowModel> { get }
}

class ViewController: UIViewController {
    @IBOutlet weak var placeholder: PlaceholderView!
    var tableVC: PlaceholderTableVC!
    var presenter: Presenter = PresenterImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableVC = PlaceholderTableVC.create()
        
        let cellGenerators = self.presenter.rows.map { (model) -> CellGenerator in
            CellGenerator(create: .generator({ () -> UILabel in
                return UILabel(frame: CGRect.zero)
            }), update: { (label: UILabel, _) in
                label.text = model.text
                label.backgroundColor = model.bgColor
                label.textAlignment = model.alignment == .left ? .left : .center
            }, clicked: model.clicked,
               deleted: model.deleted)
        }
        
        self.tableVC.rowsProvider = cellGenerators
        
        self.placeholder.insertedView = self.tableVC
    }


}

