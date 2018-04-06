//
//  ExampleSelectableTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

protocol ExampleSelectableTableSpaceDelegate: class {
    func didSelectCellWith(title: String)
}

class ExampleSelectableTableSpace: ExampleDefaultTableSpace {
    // Example showing how to disable selections
    
    weak var delegate: ExampleSelectableTableSpaceDelegate?
}

extension ExampleSelectableTableSpace: SwiftTableSpaceSelectable {
    
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        return indexPath
    }
    
    func didSelectCell(at indexPath: IndexPath, in tableView: UITableView) {
        let title = self.models[indexPath.row]
        self.delegate?.didSelectCellWith(title: title)
    }
}
