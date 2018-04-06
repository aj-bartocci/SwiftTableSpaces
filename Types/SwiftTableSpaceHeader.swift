//
//  SwiftTableSpaceHeader.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/5/18.
//

import UIKit

public protocol SwiftTableSpaceHeader {
    static var id: String { get }
    static func register(for tableView: UITableView)
}
