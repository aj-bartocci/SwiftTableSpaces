//
//  HybridViewController.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftTableSpaces

class HybridViewController: ToDoBaseViewController {
    
    private var spaces: [SwiftTableSpaceable] = []
    private let toDoSpace = ToDoTableSpace()
    private let completedToDoSpace = CompletedToDoTableSpace()
    private let keyboardListener = SwiftTableSpaceKeyboardListener()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spaces = [toDoSpace, completedToDoSpace]
        toDoSpace.delegate = self
        for space in spaces {
            space.register(for: tableView)
        }
        tableView.dataSource = self
        tableView.delegate = self
        keyboardListener.delegate = self
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func addToDo() {
        guard let text = inputField.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
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

extension HybridViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.spaces.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let space = self.spaces[section]
        return space.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let space = self.spaces[indexPath.section]
        return space.cell(forRowAt: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let space = spaces[section] as? SwiftTableSpaceDefaultHeaderTitleable
        return space?.titleForDefaultHeader(in: tableView)
    }
}

extension HybridViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let space = spaces[indexPath.section] as? SwiftTableSpaceHighlightable
        return space?.shouldHighlightCell(at: indexPath, in: tableView) ?? true
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let space = spaces[indexPath.section] as? SwiftTableSpaceSelectable
        return space?.shouldSelectCell(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let space = spaces[indexPath.section] as? SwiftTableSpaceEditable
        return space?.canEditRow(at: indexPath, in: tableView) ?? false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let space = spaces[indexPath.section] as? SwiftTableSpaceEditable
        return space?.editActionsForRow(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let space = spaces[indexPath.section] as? SwiftTableSpaceEditable
        space?.commitEditing(style: editingStyle, forRowAt: indexPath, in: tableView)
    }
}

extension HybridViewController: ToDoTableSpaceDelegate {
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

extension HybridViewController: SwiftTableSpaceKeyboardListenerDelegate {
    func keyboardWillShow(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) {
        let tableViewBottom = self.tableView.frame.origin.y + self.tableView.frame.height
        let keyboardTop = self.view.frame.height - size.height
        let overlap = tableViewBottom - keyboardTop
        if overlap > 0 {
            self.tableView.contentInset.bottom = overlap
            self.tableView.scrollIndicatorInsets.bottom = overlap
        }
    }
    
    func keyboardWillHide(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) {
        self.tableView.contentInset.bottom = 0.0
        self.tableView.scrollIndicatorInsets.bottom = 0.0
    }
}
