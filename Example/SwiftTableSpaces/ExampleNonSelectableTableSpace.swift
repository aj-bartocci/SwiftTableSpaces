//
//  ExampleNonSelectableTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ExampleNonSelectableTableSpace: ExampleDefaultTableSpace {
    // Example showing how to disable selections
}

extension ExampleNonSelectableTableSpace: SwiftTableSpaceSelectable {
    
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        return nil
    }
    
    func didSelectCell(at indexPath: IndexPath, in tableView: UITableView) {
        
    }
}

extension ExampleNonSelectableTableSpace: SwiftTableSpaceDefaultHeaderTitleable {
    
    func titleForDefaultHeader(in tableView: UITableView) -> String? {
        return "Some default title"
    }
    
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return 35.0
    }
}
