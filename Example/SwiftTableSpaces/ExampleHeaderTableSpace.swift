//
//  ExampleHeaderTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ExampleHeaderTableSpace: ExampleDefaultTableSpace {
    typealias Header = ExampleHeaderView
    private let headerId = "ExampleHeaderViewId"
    
    override func register(for tableView: UITableView) {
        super.register(for: tableView)
        let nib = UINib(nibName: "ExampleHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerId)
    }
}

extension ExampleHeaderTableSpace: SwiftTableSpaceHeaderConfigurable {
    
    func headerView(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
        return header
    }
    
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return 100.0
    }
}
