//
//  SwiftTableSpaceConformingDouble.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 3/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
@testable import SwiftTableSpaces

class SwiftTableSpaceConformingDouble: SwiftTableSpaceable {
    
    var shouldSelectIndexPath: IndexPath? = nil
    var didCallSelectIndexPath: IndexPath? = nil
    
    var shouldDeselectIndexPath: IndexPath? = nil
    var didCallDeselectIndexPath: IndexPath? = nil
    
    var header: UITableViewHeaderFooterView? = nil
    var estimatedHeaderHeight: CGFloat = 0.0
    var headerHeight: CGFloat = 0.0
    
    var footer: UITableViewHeaderFooterView? = nil
    var estimatedFooterHeight: CGFloat = 0.0
    var footerHeight: CGFloat = 0.0
    
    var canEdit = false
    var editingStyle: UITableViewCellEditingStyle?
    
    var defaultHeaderTitle: String? = nil
    var defaultFooterTitle: String? = nil
    
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

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceSelectable {
    
    func shouldSelectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        shouldSelectIndexPath = indexPath
        return indexPath
    }
    
    func didSelectCell(at indexPath: IndexPath, in tableView: UITableView) {
        didCallSelectIndexPath = indexPath
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceDeselectable {
    func shouldDeselectCell(at indexPath: IndexPath, in tableView: UITableView) -> IndexPath? {
        shouldDeselectIndexPath = indexPath
        return indexPath
    }
    
    func didDeselectCell(at indexPath: IndexPath, in tableView: UITableView) {
        didCallDeselectIndexPath = indexPath
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceHeaderConfigurable {
    
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return estimatedHeaderHeight
    }
    
    func headerHeight(for tableView: UITableView) -> CGFloat {
        return headerHeight
    }
    
    func headerView(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        return header
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceFooterConfigurable {
    
    func estimatedFooterHeight(for tableView: UITableView) -> CGFloat {
        return estimatedFooterHeight
    }
    
    func footerHeight(for tableView: UITableView) -> CGFloat {
        return footerHeight
    }
    
    func footerView(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        return footer
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceEditable {
    func canEditRow(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        return canEdit
    }
    
    func commitEditing(style: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.editingStyle = style
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceDefaultHeaderTitleable {
    
    func titleForDefaultHeader(in tableView: UITableView) -> String? {
        return defaultHeaderTitle
    }
}
