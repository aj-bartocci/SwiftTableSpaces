//
//  SwiftTableSpaceDeselectable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/5/18.
//

import UIKit

/**
 By default cells are deselectable. Implementing SwiftTableSpaceDeselectable allows you to decide whether or not cells should be deselected and receive events when a cell is deselected
 */
public protocol SwiftTableSpaceDeselectable {
    
    /// Returns the IndexPath for the cell that should be deselected. By default the provided IndexPath is returned
    func shouldDeselectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath?
    
    /// Called with the indexPath that was returned by the shouldDeselectCell function
    func didDeselectCell(at indexPath: IndexPath, in tableView: UITableView)
}

public extension SwiftTableSpaceDeselectable {
    
    func shouldDeselectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        return indexPath
    }
}
