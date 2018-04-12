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
    
    /// Called when header view is about to be displayed
    func willDisplayHeader(view: UIView)
    
    /// Called when the specified header view was removed from the table
    func didEndDisplayingHeader(view: UIView)
}

public extension SwiftTableSpaceHeaderSizable {
    func willDisplayHeader(view: UIView) { }
    func didEndDisplayingHeader(view: UIView) { }
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

