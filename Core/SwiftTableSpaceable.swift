//
//  SwiftTableSpaceable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import Foundation

public protocol SwiftTableSpaceable: SwiftTableSpaceRegisterable, SwiftTableSpaceCellGettable {
    func numberOfRows() -> Int
}
