//
//  ToDoTableSpaceDelegate.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

protocol ToDoTableSpaceDelegate: class {
    func addCompletedToDo(_ text: String, tableView: UITableView)
}
