//
//  SwiftTableSpaceSource.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

public protocol SwiftTableSpaceSource: class {
    /// The total number of spaces that will be displayed
    func numberOfSpaces(in tableView: UITableView) -> Int
    /// The SwiftTableSpaceable object at the specified index 
    func space(in tableView: UITableView, for index: Int) -> SwiftTableSpaceable
    /// Called to register cells, headers, and footers before use
    func register(for tableView: UITableView)
}
