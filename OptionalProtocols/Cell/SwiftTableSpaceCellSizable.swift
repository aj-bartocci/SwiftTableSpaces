//
//  SwiftTableSpaceCellSizable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/10/18.
//

import UIKit

public protocol SwiftTableSpaceCellSizable {
    
    /// A nonnegative floating-point value that specifies the height (in points) that the cell should be.
    func heightForCell(at indexPath: IndexPath, in tableView: UITableView) -> CGFloat
    
    /// A nonnegative floating-point value that estimates the height (in points) that the cell should be. Return UITableViewAutomaticDimension if you have no estimate.
    func estimatedHeightForCell(at indexPath: IndexPath, in tableView: UITableView) -> CGFloat
}

public extension SwiftTableSpaceCellSizable {
    func heightForCell(at indexPath: IndexPath, in tableView: UITableView) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
