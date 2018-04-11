//
//  SwiftTableSpaceCellInteractable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/10/18.
//

import UIKit

public protocol SwiftTableSpaceCellInteractable {
    
    /// Called when the table view is about to draw a cell for a particular IndexPath
    func willDisplayCell(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView)
    
    /// Called when the specified cell was removed from the table
    func didEndDisplayingCell(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView)
}

public extension SwiftTableSpaceCellInteractable {
    
    func willDisplayCell(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) { }
    
    func didEndDisplayingCell(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) { }
}
