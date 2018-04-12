//
//  SwiftTableSpaceHIghlightable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/9/18.
//

import UIKit

public protocol SwiftTableSpaceHighlightable {
    /**
     Asks whether the provided IndexPath should be highlighted. By default returns true.
     
     If false is returned then any selection selection events will be stopped.
     */
    func shouldHighlightCell(at indexPath: IndexPath, in tableView: UITableView) -> Bool

    /// Called when a cell becomes highlighted
    func didHighlightCell(at indexPath: IndexPath, in tableView: UITableView)

    /// Called when a cell stops being highlighted
    func didUnhighlightCell(at indexPath: IndexPath, in tableView: UITableView)
}

public extension SwiftTableSpaceHighlightable {
    func didHighlightCell(at indexPath: IndexPath, in tableView: UITableView) { }
    func didUnhighlightCell(at indexPath: IndexPath, in tableView: UITableView) { }
}


