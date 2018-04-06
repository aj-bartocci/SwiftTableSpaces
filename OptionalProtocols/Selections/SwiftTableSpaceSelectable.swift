//
//  SwiftTableSpaceSelectable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/5/18.
//

import UIKit

/**
 By default cells are selectable. Implementing SwiftTableSpaceSelectable allows you to decide whether or not cells should be selected and receive events when a cell is selected
 
 */
public protocol SwiftTableSpaceSelectable {
    
    /// Returns the IndexPath for the cell that should be selected. By default the provided IndexPath is returned
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath?
    
    /// Called with the indexPath that was returned by the shouldSelectCell function
    func didSelectCell(at indexPath: IndexPath, in tableView: UITableView)
}

public extension SwiftTableSpaceSelectable {
    
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        return indexPath
    }
}
