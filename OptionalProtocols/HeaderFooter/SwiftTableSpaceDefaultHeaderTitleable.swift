//
//  SwiftTableSpaceDefaultHeaderTitleable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/6/18.
//

import UIKit

public protocol SwiftTableSpaceDefaultHeaderTitleable: SwiftTableSpaceHeaderSizable {
    /// The title for the default header, ignored when a header view is supplied by SwiftTableSpaceHeaderConfigurable
    func titleForDefaultHeader(in tableView: UITableView) -> String?
}

extension SwiftTableSpaceDefaultHeaderTitleable where Self: SwiftTableSpaceHeaderSizable {
    
    public func headerHeight(for tableView: UITableView) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
