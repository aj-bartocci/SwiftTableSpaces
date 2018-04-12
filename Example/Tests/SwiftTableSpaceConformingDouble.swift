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
    
    var shouldHighlightIndexPath: IndexPath? = nil
    var didHighlightIndexPath: IndexPath? = nil
    var didUnhighlightIndexPath: IndexPath? = nil
    
    var editActionsIndexPath: IndexPath? = nil
    var editingStyleIndexPath: IndexPath? = nil
    var willBeginEditIndexPath: IndexPath? = nil
    var didEndEditIndexPath: IndexPath? = nil
    
    var willDisplayHeaderView: UIView? = nil
    var didEndDisplayHeaderView: UIView? = nil
    
    var willDisplayFooterView: UIView? = nil
    var didEndDisplayFooterView: UIView? = nil
    
    var cellHeight: CGFloat = 0.0
    var estimatedCellHeight: CGFloat = 0.0
    
    var titleForDeleteButton: String? = nil
    var accessoryButtonIndexPath: IndexPath? = nil
    
    var willDisplayCell: UITableViewCell? = nil
    var willDisplayCellIndexPath: IndexPath? = nil
    
    var didEndDisplayCell: UITableViewCell? = nil
    var didEndDisplayIndexPath: IndexPath? = nil
    
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
    
    func willDisplayHeader(view: UIView) {
        willDisplayHeaderView = view
    }
    
    func didEndDisplayingHeader(view: UIView) {
        didEndDisplayHeaderView = view
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
    
    func willDisplayFooter(view: UIView) {
        willDisplayFooterView = view
    }
    
    func didEndDisplayingFooter(view: UIView) {
        didEndDisplayFooterView = view
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceEditable {
    func canEditRow(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        return canEdit
    }
    
    func commitEditing(style: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath, in tableView: UITableView) {
        self.editingStyle = style
    }
    
    func editActionsForRow(at indexPath: IndexPath, in tableView: UITableView) -> [UITableViewRowAction]? {
        editActionsIndexPath = indexPath
        return nil
    }
    
    func editingStyleForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCellEditingStyle {
        editingStyleIndexPath = indexPath
        return .insert
    }
    
    func willBeginEditingRow(at indexPath: IndexPath, in tableView: UITableView) {
        willBeginEditIndexPath = indexPath
    }
    
    func didEndEditingRow(at indexPath: IndexPath, in tableView: UITableView) {
        didEndEditIndexPath = indexPath
    }
    
    func titleForDeleteButton(at indexPath: IndexPath, in tableView: UITableView) -> String? {
        return titleForDeleteButton
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceDefaultHeaderTitleable {
    
    func titleForDefaultHeader(in tableView: UITableView) -> String? {
        return defaultHeaderTitle
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceDefaultFooterTitleable {
    
    func titleForDefaultFooter(in tableView: UITableView) -> String? {
        return defaultFooterTitle
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceHighlightable {
    func shouldHighlightCell(at indexPath: IndexPath, in tableView: UITableView) -> Bool {
        shouldHighlightIndexPath = indexPath
        return true
    }
    
    func didHighlightCell(at indexPath: IndexPath, in tableView: UITableView) {
        didHighlightIndexPath = indexPath
    }
    
    func didUnhighlightCell(at indexPath: IndexPath, in tableView: UITableView) {
        didUnhighlightIndexPath = indexPath
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceCellSizable {
    
    func heightForCell(at indexPath: IndexPath, in tableView: UITableView) -> CGFloat {
        return cellHeight
    }
    
    func estimatedHeightForCell(at indexPath: IndexPath, in tableView: UITableView) -> CGFloat {
        return estimatedCellHeight
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceActionable {
    func accessoryButtonTappedAt(indexPath: IndexPath, in tableView: UITableView) {
        accessoryButtonIndexPath = indexPath
    }
}

extension SwiftTableSpaceConformingDouble: SwiftTableSpaceCellInteractable {
    func willDisplayCell(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        willDisplayCell = cell
        willDisplayCellIndexPath = indexPath
    }
    
    func didEndDisplayingCell(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        didEndDisplayCell = cell
        didEndDisplayIndexPath = indexPath
    }
}


