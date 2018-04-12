//
//  CompletedToDoTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class CompletedToDoTableSpace: ToDoBaseTableSpace {
    
    func addToDo(_ model: String, tableView: UITableView, section: Int) {
        let lastIndex = self.models.count
        let indexPath = IndexPath(row: lastIndex, section: section)
        self.addModel(model)
        commitEditing(style: .insert, forRowAt: indexPath, in: tableView)
    }
}

extension CompletedToDoTableSpace: SwiftTableSpaceDefaultHeaderTitleable {
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return 20.0
    }
    func titleForDefaultHeader(in tableView: UITableView) -> String? {
        return "Completed ToDos"
    }
}

extension CompletedToDoTableSpace: SwiftTableSpaceEditable {
    func canEditRow(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        return true
    }
    
    func commitEditing(style: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath, in tableView: UITableView) {
        switch style {
        case .delete:
            self.removeModel(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            break
        case .insert:
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            break
        default:
            break
        }
    }
    
    func titleForDeleteButton(at indexPath: IndexPath, in tableView: UITableView) -> String? {
        return "Delete"
    }
}

extension CompletedToDoTableSpace: SwiftTableSpaceHighlightable {
    func shouldHighlightCell(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        return false
    }
}

extension CompletedToDoTableSpace: SwiftTableSpaceSelectable {
    
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        return nil 
    }
    func didSelectCell(at indexPath: IndexPath, in tableView: UITableView) {
        
    }
}
