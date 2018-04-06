////
////  SwiftTableSpaceManager.swift
////  SwiftTableSpaces
////
////  Created by AJ Bartocci on 3/20/18.
////
//
//import UIKit
//
//protocol SwiftTableSpaceManagerDelegate: class {
//    func registerCells(for tableView: UITableView)
//}
//
//class SwiftTableSpaceManager {
//    
//    private let dataSource = SwiftTableSpaceDataSource()
//    //    private let delegate = TableViewDelegate()
//    fileprivate (set) weak var tableView: UITableView?
//    
//    //    fileprivate lazy var keyboardListener = TableSpaceKeyboardListener()
//    //    weak var keyboardDelegate: TableSpaceKeyboardListenerDelegate? {
//    //        didSet {
//    //            keyboardListener.delegate = keyboardDelegate
//    //        }
//    //    }
//    
//    weak var spaceSource: SwiftTableSpaceSource! {
//        didSet {
//            dataSource.spaceSource = spaceSource
//            //            delegate.sectionSource = sectionSource
//        }
//    }
//    
//    init(tableView: UITableView, source: SwiftTableSpaceSource) {
//        source.registerCells(for: tableView)
//        self.tableView = tableView
//        self.dataSource.spaceSource = source
//        //        self.delegate.sectionSource = source
//        tableView.dataSource = dataSource
//        //        tableView.delegate = delegate
//    }
//    
//    func reloadTableView() {
//        self.tableView?.reloadData()
//    }
//    
//}
//
//
