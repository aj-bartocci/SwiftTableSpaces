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
    
    let dataSource = SwiftTableSpaceDataSource()
    let delegate = SwiftTableSpaceDelegate()
    weak var tableView: UITableView?
        
    public var interactor: Interactor {
        didSet {
            dataSource.spaceSource = interactor
            delegate.spaceSource = interactor
        }
    }
    
    lazy var keyboardListener = SwiftTableSpaceKeyboardListener()
    /**
     Sends events when the keyboard is presented and dismissed
     
     Anytime the view is no longer showing the keyboardDelegate associated with that view should be nullified. For example if implemented with a UIViewController it should be nullified in viewWillDisappear and set in viewWillAppear
    */
    public weak var keyboardDelegate: SwiftTableSpaceKeyboardListenerDelegate? {
        didSet {
            keyboardListener.delegate = keyboardDelegate
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
