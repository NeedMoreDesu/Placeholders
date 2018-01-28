//
//  IHYLVCError.swift
//  IHeardYouLiekViewControllers
//
//  Created by Oleksii Horishnii on 4/8/17.
//  Copyright © 2017 Oleksii Horishnii. All rights reserved.
//

import Foundation

public enum VCSError: Error {
    case wrongStoryboardId // when can't find storyboard with name
    case wrongVcId // when can't find vc with said ID
    
    case storyboardIdIsEmpty
    case vcIdIsEmpty
    
    case viewControllerTypeMismatch
    
    case parentVCnotFound  // is thrown when container view cannot determine VC where it is used
    case tableViewNotSet // is thrown when tableView not set; should use create(tableView:reuseID:indexPath:) method
}
