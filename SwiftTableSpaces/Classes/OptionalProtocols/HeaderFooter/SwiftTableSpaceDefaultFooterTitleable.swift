//
//  SwiftTableSpaceDefaultFooterTitleable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/9/18.
//

import UIKit

public protocol SwiftTableSpaceDefaultFooterTitleable: SwiftTableSpaceFooterSizable {
    /// The title for the default footer, ignored when a footer view is supplied by SwiftTableSpaceFooterConfigurable
    func titleForDefaultFooter(in tableView: UITableView) -> String?
}

public extension SwiftTableSpaceDefaultFooterTitleable {

    public func footerHeight(for tableView: UITableView) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
