//
//  VCSTableView.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/11/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation
import UIKit
import ObservedObjects

open class VCSTableVC: UITableViewController {
    //MARK: input
    open var strongRefs: [AnyObject] = []
    open var topViewControllers: [VCSController] = [] { didSet { self.updateUI() } }
    open var bottomViewControllers: [VCSController] = [] { didSet { self.updateUI() } }
    open var observed: ObservedObjects<VCSController>? {
        didSet {
            observed?.willChangeContent = { [weak self] in
                self?.tableView.beginUpdates()
            }
            observed?.insertFn = { [weak self] (idx) in
                self?.tableView.insertRows(at: [IndexPath.init(row: idx, section: 0)], with: .automatic)
            }
            observed?.deleteFn = { [weak self] (idx) in
                self?.tableView.deleteRows(at: [IndexPath.init(row: idx, section: 0)], with: .fade)
            }
            observed?.updateFn = { [weak self] (idx) in
                self?.tableView.reloadRows(at: [IndexPath.init(row: idx, section: 0)], with: .automatic)
            }
            observed?.moveFn = { [weak self] (oldIdx, newIdx) in
                self?.tableView.deleteRows(at: [IndexPath.init(row: oldIdx, section: 0)], with: .automatic)
                self?.tableView.insertRows(at: [IndexPath.init(row: newIdx, section: 0)], with: .automatic)
            }
            observed?.fullReloadFn = { [weak self] in
                self?.updateUI()
            }
            observed?.didChangeContent = { [weak self] in
                self?.tableView.endUpdates()
            }
            self.updateUI()
        }
    }
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
        return self.topViewControllers.count + self.bottomViewControllers.count + (self.observed?.objs.count ?? 0)
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var idx = indexPath.row
        var vc: VCSController?
        
        var cell: VCSTableViewCell!

        if(idx < self.topViewControllers.count) {
            vc = self.topViewControllers[idx]
        } else {
            idx -= self.topViewControllers.count
            if (idx < (self.observed?.objs.count ?? 0)) {
                vc = self.observed?.objs.get(idx, reusingFn: { reusingId in
                    guard let reusingId = reusingId as? String else {
                        return nil
                    }
                    self.registerReuseId(reuseId: reusingId)
                    cell = VCSTableViewCell.create(tableView: tableView, reuseID: reusingId, indexPath: indexPath)
                    return cell.insertedController
                })
            } else {
                idx -= (self.observed?.objs.count ?? 0)
                vc = self.bottomViewControllers[idx]
            }
        }
        
        if cell == nil {
            cell = VCSTableViewCell.create(tableView: tableView, reuseID: mainReuseId, indexPath: indexPath)
        }
        cell.insertedController = vc
        
        return cell
    }
}
