//
//  VCSTableView.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/11/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

open class VCSTableVC: UITableViewController {
    //MARK: input
    open var tableContents: RowsProvider<TableViewCellGenerator>!
    open var estimatedHeight: Double = 42.0 { didSet { self.updateUI() } }
    
    //MARK: VC creation
    open class func create(builderFn:((VCSTableVC) -> Void)? = nil) -> VCSTableVC {
        let vc: VCSTableVC = ContainersUtils.createVC(storyboardId: "VCSTableView", vcId: "VCSTableVC")
        builderFn?(vc)
        return vc
    }
    //MARK: change values
    func performChange(changeFn:((VCSTableVC) -> Void)? = nil) {
        changeFn?(self)
        self.updateUI()
    }
    
    //MARK:- lifecycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //MARK:- outlets
    
    //MARK:- internal variables
    var reuseIds = Set<String>()
    
    //MARK:- UI
    func setupUI() {
        self.tableView?.rowHeight = UITableViewAutomaticDimension

        self.updateUI()
    }
    
    public func updateUI() {
        self.tableView?.estimatedRowHeight = CGFloat(self.estimatedHeight)
        self.tableView?.reloadData()
    }

    //MARK:- actions

    //MARK:- tableView delegate
    override open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.estimatedHeight)
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK:- tableView data source
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableContents.rows(section: section)
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let generator = self.tableContents.generator(path: indexPath) as TableViewCellGenerator
        
        if (!self.reuseIds.contains(generator.reuseId)) {
            generator.registerReuseId(tableView: tableView)
            self.reuseIds.insert(generator.reuseId)
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: generator.reuseId, for: indexPath)
        generator.updateCell(cell: cell, vc: self)
        return cell
    }
}

extension VCSTableVC: RowsUpdateDelegate {
    public func willChangeContent() {
        self.tableView.beginUpdates()
    }
    
    public func didChangeContent() {
        self.tableView.endUpdates()
    }
    
    public func insert(paths: [IndexPath]) {
        self.tableView.insertRows(at: paths, with: .automatic)
    }
    
    public func delete(paths: [IndexPath]) {
        self.tableView.deleteRows(at: paths, with: .fade)
    }
    
    public func update(paths: [IndexPath]) {
        self.tableView.reloadRows(at: paths, with: .automatic)
    }
}
