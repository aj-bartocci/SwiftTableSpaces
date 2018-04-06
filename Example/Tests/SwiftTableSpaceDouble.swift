//
//  SwiftTableSpaceDouble.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 3/20/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
@testable import SwiftTableSpaces

class SwiftTableSpaceDouble: SwiftTableSpaceable {
    
    var rowCount: Int
    fileprivate (set) var calledRegister = false
    init(numberOfRows: Int) {
        self.rowCount = numberOfRows
    }
    
    func numberOfRows() -> Int {
        return self.rowCount
    }
    
    func register(for tableView: UITableView) {
        calledRegister = true
    }
    
    func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
