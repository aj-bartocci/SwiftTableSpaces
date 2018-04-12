//
//  SwiftTableSpaceFooter.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/5/18.
//

import UIKit

public protocol SwiftTableSpaceFooter {
    static var id: String { get }
    static func register(for tableView: UITableView)
}

