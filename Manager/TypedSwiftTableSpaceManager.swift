//
//  TypedSwiftTableSpaceManager.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

protocol TypedSwiftTableSpaceManagerDelegate: class {
    func registerCells(for tableView: UITableView)
}

class TypedSwiftTableSpaceManager<Interactor: SwiftTableSpaceInteractor> {
    
    private let dataSource = SwiftTableSpaceDataSource()
    //    private let delegate = TableViewDelegate()
    fileprivate weak var tableView: UITableView?
    
    //    fileprivate lazy var keyboardListener = TableSpaceKeyboardListener()
    //    weak var keyboardDelegate: TableSpaceKeyboardListenerDelegate? {
    //        didSet {
    //            keyboardListener.delegate = keyboardDelegate
    //        }
    //    }
    
//    weak var spaceSource: SwiftTableSpaceInteractor! {
//        didSet {
//            dataSource.spaceSource = spaceSource
////            delegate.sectionSource = sectionSource
//        }
//    }
    
    var interactor: Interactor {
        didSet {
            dataSource.spaceSource = interactor
        }
    }
    init(tableView: UITableView, interactor: Interactor) {
        self.interactor = interactor
        interactor.register(for: tableView)
        self.tableView = tableView
        self.dataSource.spaceSource = interactor
        //        self.delegate.sectionSource = source
        tableView.dataSource = dataSource
        //        tableView.delegate = delegate
    }
    
//    func reloadTableView() {
//        self.tableView?.reloadData()
//    }
    
}


