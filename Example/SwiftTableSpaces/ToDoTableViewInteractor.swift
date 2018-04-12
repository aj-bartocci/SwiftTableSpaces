//
//  ToDoTableViewInteractor.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ToDoTableViewInteractor: SwiftTableSpaceInteractor {
    
    private var spaces: [SwiftTableSpaceable]
    private let toDoSpace = ToDoTableSpace()
    private let completedToDoSpace = CompletedToDoTableSpace()
    init() {
        spaces = [toDoSpace, completedToDoSpace]
        toDoSpace.delegate = self
    }
    
    func numberOfSpaces(in tableView: UITableView) -> Int {
        return spaces.count
    }
    
    func space(in tableView: UITableView, for index: Int) -> SwiftTableSpaceable {
        return spaces[index]
    }
    
    func register(for tableView: UITableView) {
        for space in spaces {
            space.register(for: tableView)
        }
    }
    
    func addToDo(text: String, tableView: UITableView) {
        let sectionIndex = spaces.index { (space) -> Bool in
            if let s = space as? ToDoTableSpace {
                return s == self.toDoSpace
            }
            return false
        }
        guard let section = sectionIndex else {
            return
        }
        self.toDoSpace.addToDo(text, tableView: tableView, section: section)
    }
}

extension ToDoTableViewInteractor: ToDoTableSpaceDelegate {
    
    func addCompletedToDo(_ text: String, tableView: UITableView) {
        let sectionIndex = spaces.index { (space) -> Bool in
            if let s = space as? CompletedToDoTableSpace {
                return s == self.completedToDoSpace
            }
            return false
        }
        guard let section = sectionIndex else {
            return
        }
        self.completedToDoSpace.addToDo(text, tableView: tableView, section: section)
    }
}
