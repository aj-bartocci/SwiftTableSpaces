//
//  SwiftTableSpaceActionable.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 4/10/18.
//

import UIKit

public protocol SwiftTableSpaceActionable {
    
    /**
     The delegate usually responds to the tap on the disclosure button. This method is not called when an accessory view is set for the row at indexPath.
    */
    func accessoryButtonTappedAt(indexPath: IndexPath, in tableView: UITableView)
}

public extension SwiftTableSpaceActionable {
    func accessoryButtonTappedAt(indexPath: IndexPath, in tableView: UITableView) { }
}
