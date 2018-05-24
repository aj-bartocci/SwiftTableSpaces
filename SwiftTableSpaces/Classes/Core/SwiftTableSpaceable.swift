//
//  SwiftTableSpaceable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import Foundation

/// Choosing to force it as a class for equivelency 
public protocol SwiftTableSpaceable: class, SwiftTableSpaceRegisterable, SwiftTableSpaceCellGettable {
    func numberOfRows() -> Int
}
