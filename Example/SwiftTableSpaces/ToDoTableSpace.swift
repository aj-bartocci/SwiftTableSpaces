//
//  ToDoTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ToDoTableSpace: ToDoBaseTableSpace {
    
    weak var delegate: ToDoTableSpaceDelegate?
    
    func addToDo(_ model: String, tableView: UITableView, section: Int) {
        let lastIndex = self.models.count
        let indexPath = IndexPath(row: lastIndex, section: section)
        self.addModel(model)
        commitEditing(style: .insert, forRowAt: indexPath, in: tableView)
    }
}

extension ToDoTableSpace: SwiftTableSpaceDefaultHeaderTitleable {
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return 20.0
    }
    
    func titleForDefaultHeader(in tableView: UITableView) -> String? {
        return "ToDos"
    }
}

extension ToDoTableSpace: SwiftTableSpaceHighlightable {
    func shouldHighlightCell(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        return false
    }
}

extension ToDoTableSpace: SwiftTableSpaceSelectable {
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        return nil
    }
    
    func didSelectCell(at indexPath: IndexPath, in tableView: UITableView) {
        
    }
}

extension ToDoTableSpace: SwiftTableSpaceEditable {
    
    func canEditRow(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        return true
    }
    
    func commitEditing(style: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath, in tableView: UITableView) {
        switch style {
        case .delete:
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
    
    func editActionsForRow(at indexPath: IndexPath, in tableView: UITableView) -> [UITableViewRowAction]? {
        let complete = UITableViewRowAction(style: .normal, title: "Complete") { [weak self] (action, indexPath) in
            // remove and call delegate to add to other section
            self?.completeAt(indexPath: indexPath, in: tableView)
        }
        complete.backgroundColor = .green
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            // delete
            self?.removeAt(indexPath: indexPath, in: tableView)
        }
        return [delete, complete]
    }
    
    private func completeAt(indexPath: IndexPath, in tableView: UITableView) {
        let model = self.models[indexPath.row]
        self.removeAt(indexPath: indexPath, in: tableView)
        self.delegate?.addCompletedToDo(model, tableView: tableView)
    }
    
    private func removeAt(indexPath: IndexPath, in tableView: UITableView) {
        self.removeModel(at: indexPath.row)
        self.commitEditing(style: .delete, forRowAt: indexPath, in: tableView)
    }
}
