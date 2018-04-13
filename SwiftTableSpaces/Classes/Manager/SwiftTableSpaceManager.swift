//
//  SwiftTableSpaceManager.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

public class SwiftTableSpaceManager {
    
    let dataSource = SwiftTableSpaceDataSource()
    let delegate = SwiftTableSpaceDelegate()
    weak var tableView: UITableView?
    
    /**
     The interactor that will be used to do the configuration.
     
     The interactor will be weakly referenced so it must be retained by something other than the SwiftTableSpaceManager
    */
    public weak var interactor: SwiftTableSpaceInteractor! {
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
    
    /**
     Initializes with the tableview to be configured and an interactor that will be used to do the configuration.
     
     The interactor will be weakly referenced so it must be retained by something other than the SwiftTableSpaceManager
     */
    public init(tableView: UITableView, interactor: SwiftTableSpaceInteractor) {
        self.interactor = interactor
        self.tableView = tableView
        self.dataSource.spaceSource = interactor
        self.delegate.spaceSource = interactor
        interactor.register(for: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
}


