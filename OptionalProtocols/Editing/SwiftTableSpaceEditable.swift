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
}
