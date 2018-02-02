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
    open var rowsProvider: RowsProvider<TableViewCellGenerator>? {
        didSet {
            oldValue?.updateDelegate = nil
            self.rowsProvider?.updateDelegate = self
        }
    }
    open var sectionsHeaderProvider: SectionsProvider<AnyView>?
    open var sectionsFooterProvider: SectionsProvider<AnyView>?
    open var estimatedRowHeight: Double = 42.0 { didSet { self.updateUI() } }
    open var estimatedSectionHeaderHeight: Double = 42.0 { didSet { self.updateUI() } }
    open var estimatedSectionFooterHeight: Double = 42.0 { didSet { self.updateUI() } }

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
        self.tableView?.estimatedRowHeight = CGFloat(self.estimatedRowHeight)
        self.tableView?.estimatedSectionHeaderHeight = CGFloat(self.estimatedSectionHeaderHeight)
        self.tableView?.estimatedSectionFooterHeight = CGFloat(self.estimatedSectionFooterHeight)
        self.tableView?.reloadData()
    }

    //MARK:- actions

    //MARK:- tableView delegate
    override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.sectionsHeaderProvider?.section(section: section) != nil ?
            UITableViewAutomaticDimension :
            CGFloat(0.0)
    }

    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.sectionsFooterProvider?.section(section: section) != nil ?
            UITableViewAutomaticDimension :
            CGFloat(0.0)
    }

    //MARK:- tableView data source
    open override func numberOfSections(in tableView: UITableView) -> Int {
        return self.rowsProvider?.sections() ?? 0
    }
    
    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsProvider?.rows(section: section) ?? 0
    }
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let section = self.sectionsHeaderProvider?.section(section: section) {
            let container = ContainerView()
            container.controllingVC = self
            container.insertedView = section
            return container
        }
        return UIView(frame: CGRect.zero)
    }
    
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let section = self.sectionsFooterProvider?.section(section: section) {
            let container = ContainerView()
            container.controllingVC = self
            container.insertedView = section
            return container
        }
        return UIView(frame: CGRect.zero)
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let generator = self.rowsProvider?.generator(path: indexPath) {
            if (!self.reuseIds.contains(generator.reuseId)) {
                generator.registerReuseId(tableView: tableView)
                self.reuseIds.insert(generator.reuseId)
            }
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: generator.reuseId, for: indexPath)
            generator.updateCell(cell: cell, vc: self)
            return cell
        }
        return UITableViewCell()
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
