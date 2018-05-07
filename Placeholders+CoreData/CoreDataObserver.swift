//
//  CoreDataObserver.swift
//  Placeholders+CoreData
//
//  Created by Oleksii Horishnii on 5/7/18.
//  Copyright © 2018 Oleksii Horishnii. All rights reserved.
//

import Foundation
import CoreData
import Placeholders

public struct FetchRequestParameters {
    public var sortDescriptors: [NSSortDescriptor]
    public var predicate: NSPredicate?
    public var fetchBatchSize: Int
    public var sectionNameKeyPath: String?
    public init(sortDescriptors: [NSSortDescriptor],
                predicate: NSPredicate? = nil,
                fetchBatchSize: Int? = nil,
                sectionNameKeyPath: String? = nil) {
        self.sortDescriptors = sortDescriptors
        self.predicate = predicate
        self.fetchBatchSize = fetchBatchSize ?? 20
        self.sectionNameKeyPath = sectionNameKeyPath
    }
}

open class CoreDataObserver<Type>: NSObject, NSFetchedResultsControllerDelegate where Type: NSManagedObject {
    private var controller: NSFetchedResultsController<Type>
    private class func fetchResultController(entityName: String,
                                             managedObjectContext: NSManagedObjectContext,
                                             params: FetchRequestParameters) -> NSFetchedResultsController<Type> {
        let request = NSFetchRequest<Type>(entityName: entityName)
        request.predicate = params.predicate
        request.fetchBatchSize = params.fetchBatchSize
        request.sortDescriptors = params.sortDescriptors
        
        let fetchedResultsController = NSFetchedResultsController<Type>(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: params.sectionNameKeyPath, cacheName: nil)
        
        return fetchedResultsController
    }
    
    init(fetchedResultController: NSFetchedResultsController<Type>) {
        self.controller = fetchedResultController
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            abort()
        }
        
        super.init()
        
        fetchedResultController.delegate = self
    }
    
    public class func create(entityName: String,
                             managedObjectContext: NSManagedObjectContext,
                             params: FetchRequestParameters) -> RowsProvider<Type> {
        let fetchedResultController = CoreDataObserver.fetchResultController(entityName: entityName,
                                                                             managedObjectContext: managedObjectContext,
                                                                             params: params)
        let observer = CoreDataObserver(fetchedResultController: fetchedResultController)
        
        return observer.setupObservedSections()
    }
    
    public class func create(fetchedResultController: NSFetchedResultsController<Type>) -> RowsProvider<Type> {
        let observer = CoreDataObserver(fetchedResultController: fetchedResultController)
        
        return observer.setupObservedSections()
    }
    
    weak var rows: RowsProvider<Type>?
    weak var sections: SectionsProvider<Type>?
    private func setupObservedSections() -> RowsProvider<Type> {
        let rows = RowsProvider(sections: { () -> Int in
            return self.controller.sections?.count ?? 0
        }, rows: { (section) -> Int in
            if let sections = self.controller.sections {
                if section < sections.count {
                    return sections[section].numberOfObjects
                }
            }
            return 0
        }) { (indexPath) -> Type in
            let obj = self.controller.object(at: IndexPath(row: indexPath.row, section: indexPath.section))
            return obj
        }
        self.rows = rows
        return rows
    }
    
    private var deletions: [IndexPath] = []
    private var insertions: [IndexPath] = []
    private var updates: [IndexPath] = []
    private var sectionDeletions: [Int] = []
    private var sectionInsertions: [Int] = []
    func resetChanges() {
        self.deletions = []
        self.insertions = []
        self.updates = []
        self.sectionDeletions = []
        self.sectionInsertions = []
    }
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.resetChanges()
        self.rows?.willChangeContent()
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.rows?.insert(paths: self.insertions)
        self.rows?.update(paths: self.updates)
        self.rows?.delete(paths: self.deletions)
        self.rows?.sectionInsert(sections: sectionInsertions)
        self.rows?.sectionDelete(sections: sectionDeletions)
        
        self.resetChanges()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange anObject: Any,
                           at indexPath: IndexPath?,
                           for type: NSFetchedResultsChangeType,
                           newIndexPath: IndexPath?) {
        var type = type
        if (type == .update && newIndexPath != nil && indexPath?.compare(newIndexPath!) != .orderedSame) {
            type = .move;
        }
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                self.insertions.append(indexPath)
            }
        case .delete:
            if let indexPath = indexPath {
                self.deletions.append(indexPath)
            }
        case .update:
            if let indexPath = indexPath {
                self.updates.append(indexPath)
            }
        case .move:
            if let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath {
                self.deletions.append(oldIndexPath)
                self.insertions.append(newIndexPath)
            }
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                           didChange sectionInfo: NSFetchedResultsSectionInfo,
                           atSectionIndex sectionIndex: Int,
                           for type: NSFetchedResultsChangeType) {
        switch (type) {
        case .insert:
            self.sectionInsertions.append(sectionIndex)
            break
        case .delete:
            self.sectionDeletions.append(sectionIndex)
            break
        default:
            break
        }
    }
}
