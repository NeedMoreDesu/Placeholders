//
//  VCSTableView.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/11/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit

protocol TableUpdateDelegate {
    func willChangeContent()
    func didChangeContent()

    func insert(paths: [IndexPath])
    func delete(paths: [IndexPath])
    func update(paths: [IndexPath])
    
    func updateUI()
}

open class VCSTableVC: UITableViewController, TableUpdateDelegate {
    func willChangeContent() {
        self.tableView.beginUpdates()
    }
    
    func didChangeContent() {
        self.tableView.endUpdates()
    }
    
    func insert(paths: [IndexPath]) {
        self.tableView.insertRows(at: paths, with: .automatic)
    }
    
    func delete(paths: [IndexPath]) {
        self.tableView.deleteRows(at: paths, with: .fade)
    }
    
    func update(paths: [IndexPath]) {
        self.tableView.reloadRows(at: paths, with: .automatic)
    }
    
    //MARK: input
    open var tableContents: TableContents!
    open var estimatedHeight: Double = 42.0 { didSet { self.updateUI() } }
    
    //MARK: VC creation
    open class func create(builderFn:((VCSTableVC) -> Void)? = nil) -> VCSTableVC {
        let vc: VCSTableVC = try! VCSUtils.createVC(storyboardId: "VCSTableView", vcId: "VCSTableVC")
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
    let mainReuseId = "__main_reuse_id"
    
    //MARK:- UI
    func setupUI() {
        self.registerReuseId(reuseId: mainReuseId)

        self.tableView?.rowHeight = UITableViewAutomaticDimension

        self.updateUI()
    }
    
    func updateUI() {
        self.tableView?.estimatedRowHeight = CGFloat(self.estimatedHeight)
        self.tableView?.reloadData()
    }
    
    //MARK:- actions
    
    //MARK:- inner
    var reuseIds = Set<String>()
    func registerReuseId(reuseId: String) {
        if (self.reuseIds.contains(reuseId)) {
            return
        }
        let type = VCSTableViewCell.self
        let bundle = Bundle(for: type)
        let nib = UINib(nibName: "VSCTableViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: reuseId)
        self.reuseIds.insert(reuseId)
    }
    
    //MARK:- tableView delegate
    override open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.estimatedHeight)
    }
    
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK:- tableView data source
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableContents.rows(inSection: section)
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: VCSTableViewCell!
        
        let reuseId = self.tableContents.reuseId(path: indexPath)
        self.registerReuseId(reuseId: reuseId)
        cell = VCSTableViewCell.create(tableView: tableView, reuseID: reuseId, indexPath: indexPath)
        self.tableContents.updateCell(path: indexPath, cell: cell)
        
        return cell
    }
}
