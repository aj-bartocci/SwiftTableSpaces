//
//  SwiftTableSpaceManager.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

public protocol SwiftTableSpaceManagerDelegate: class {
    func registerCells(for tableView: UITableView)
}

public class SwiftTableSpaceManager<Interactor: SwiftTableSpaceInteractor> {
    
    private let dataSource = SwiftTableSpaceDataSource()
    private let delegate = SwiftTableSpaceDelegate()
    fileprivate (set) weak var tableView: UITableView?
    
//    fileprivate lazy var keyboardListener = TableSpaceKeyboardListener()
//    weak var keyboardDelegate: TableSpaceKeyboardListenerDelegate? {
//        didSet {
//            keyboardListener.delegate = keyboardDelegate
//        }
//    }
    
    public var interactor: Interactor {
        didSet {
            dataSource.spaceSource = interactor
            delegate.spaceSource = interactor
        }
    }
    
    public init(tableView: UITableView, interactor: Interactor) {
        self.interactor = interactor
        self.tableView = tableView
        self.dataSource.spaceSource = interactor
        self.delegate.spaceSource = interactor
        interactor.register(for: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
}
