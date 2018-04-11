//
//  SwiftTableSpaceEditable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/6/18.
//

import UIKit

public protocol SwiftTableSpaceEditable {
    /// Return true if row can be edited, defaults to false
    func canEditRow(at indexPath: IndexPath, in tableView: UITableView) -> Bool
    
    func commitEditing(style: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    
    /**
     Provides custom editActions for specified row.
     
     By default returns nil and apple implements default editActions
     
     See UITableViewDelegate function tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
 
     */
    func editActionsForRow(at indexPath: IndexPath, in tableView: UITableView) -> [UITableViewRowAction]?
    
    /**
     Returns the editing style for a specific row. Delete style is returned default.
     
     editActionsForRow takes precedence
    */
    func editingStyleForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCellEditingStyle
    
    /// Called when user begins editing at supplied IndexPath
    func willBeginEditingRow(at indexPath: IndexPath, in tableView: UITableView)

    /// Called when user stops editing at supplied IndexPath
    func didEndEditingRow(at indexPath: IndexPath, in tableView: UITableView)
    
    /// The title for the default delete button
    func titleForDeleteButton(at indexPath: IndexPath, in tableView: UITableView) -> String?
    
//
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//    return true
//    }
}

public extension SwiftTableSpaceEditable {
    func editActionsForRow(at indexPath: IndexPath, in tableView: UITableView) -> [UITableViewRowAction]? {
        return nil
    }
    
    func editingStyleForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func willBeginEditingRow(at indexPath: IndexPath, in tableView: UITableView) { }
    
    func didEndEditingRow(at indexPath: IndexPath, in tableView: UITableView) { }
    
    func titleForDeleteButton(at indexPath: IndexPath, in tableView: UITableView) -> String? {
        return nil
    }
}
