//
//  SwiftTableSpaceFooterConfigurable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/5/18.
//

import UIKit

public protocol SwiftTableSpaceFooterSizable {
    /// The estimated height for the footer, returns UITableViewAutomaticDimension by default
    func estimatedFooterHeight(for tableView: UITableView) -> CGFloat
    /// The height for the footer, returns UITableViewAutomaticDimension by default
    func footerHeight(for tableView: UITableView) -> CGFloat
    
    /// Called when a footer view is about to be displayed for the specified section
    func willDisplayFooter(view: UIView)
    
    /// Called when the specified footer view was removed from the table
    func didEndDisplayingFooter(view: UIView)
}

public extension SwiftTableSpaceFooterSizable {
    func willDisplayFooter(view: UIView) { }
    func didEndDisplayingFooter(view: UIView) { }
}

public protocol SwiftTableSpaceFooterConfigurable: SwiftTableSpaceFooterSizable {
//    func registerFooter(for tableView: UITableView)
    func footerView(for tableView: UITableView) -> UITableViewHeaderFooterView?
}

public extension SwiftTableSpaceFooterConfigurable {
    
    func estimatedFooterHeight(for tableView: UITableView) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func footerHeight(for tableView: UITableView) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
