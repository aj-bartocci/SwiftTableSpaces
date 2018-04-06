//
//  SwiftTableSpaceHeaderConfigurable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/5/18.
//

import UIKit

public protocol SwiftTableSpaceHeaderSizable {
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat
    func headerHeight(for tableView: UITableView) -> CGFloat
}

public protocol SwiftTableSpaceHeaderConfigurable: SwiftTableSpaceHeaderSizable {
//    func registerHeader(for tableView: UITableView)
    func headerView(for tableView: UITableView) -> UITableViewHeaderFooterView?
    
    // for whatever reason the estimated height must be provided
    // for the automatic sizing to work
    /// The estimated height of the header
}

public extension SwiftTableSpaceHeaderConfigurable {
    func headerHeight(for tableView: UITableView) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

