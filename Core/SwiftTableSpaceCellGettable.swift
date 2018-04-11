//
//  SwiftTableSpaceCellGettable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

public protocol SwiftTableSpaceCellGettable {
    func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
