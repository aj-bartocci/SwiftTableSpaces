//
//  SwiftTableSpaceSourceDouble.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 3/20/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
@testable import SwiftTableSpaces

class SwiftTableSpaceSourceDouble: SwiftTableSpaceInteractor {
    
    var spaces: [SwiftTableSpaceable]
    var calledRegisterCells = false
    init(spaces: [SwiftTableSpaceable]) {
        self.spaces = spaces
    }
    
    func numberOfSpaces(in tableView: UITableView) -> Int {
        return self.spaces.count
    }
    
    func spaces(in tableView: UITableView) -> [SwiftTableSpaceable] {
        return self.spaces
    }
    
    func space(in tableView: UITableView, for index: Int) -> SwiftTableSpaceable {
        return self.spaces[index]
    }
    
    func register(for tableView: UITableView) {
        calledRegisterCells = true 
    }
}
