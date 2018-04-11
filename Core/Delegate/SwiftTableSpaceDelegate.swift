//
//  SwiftTableSpaceDelegate.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import Foundation

class SwiftTableSpaceDelegate: NSObject, UITableViewDelegate {
    weak var spaceSource: SwiftTableSpaceSource?
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceSelectable
    private typealias Selectable = SwiftTableSpaceSelectable
    
    /// Default implementation returns the supplied indexPath
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Selectable {
            return space.shouldSelectCell(at: indexPath, in: tableView)
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Selectable
        space?.didSelectCell(at: indexPath, in: tableView)
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceCellSizable
    typealias CellSizable = SwiftTableSpaceCellSizable
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? CellSizable
        return space?.heightForCell(at: indexPath, in: tableView) ?? UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? CellSizable
        return space?.estimatedHeightForCell(at: indexPath, in: tableView) ?? UITableViewAutomaticDimension
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceDeselectable
    private typealias Deselectable = SwiftTableSpaceDeselectable
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Deselectable {
            return space.shouldDeselectCell(at: indexPath, in: tableView)
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Deselectable
        space?.didDeselectCell(at: indexPath, in: tableView)
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceHighlightable
    
    typealias Highlightable = SwiftTableSpaceHighlightable
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // by default apple returns true
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Highlightable
        return space?.shouldHighlightCell(at: indexPath, in: tableView) ?? true
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Highlightable
        space?.didHighlightCell(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Highlightable
        space?.didUnhighlightCell(at: indexPath, in: tableView)
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: Editing
    
    typealias Editable = SwiftTableSpaceEditable
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Editable
        space?.willBeginEditingRow(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard let i = indexPath else {
            return
        }
        let space = spaceSource?.space(in: tableView, for: i.section) as? Editable
        space?.didEndEditingRow(at: i, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Editable
        return space?.editActionsForRow(at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Editable
        return space?.editingStyleForRow(at: indexPath, in: tableView) ?? .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Editable
        return space?.titleForDeleteButton(at: indexPath, in: tableView)
    }
    
//
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceHeader
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceHeaderSizable {
            return space.estimatedHeaderHeight(for: tableView)
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceHeaderSizable {
            return space.headerHeight(for: tableView)
        } else {
            return CGFloat.leastNonzeroMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceHeaderConfigurable
        return space?.headerView(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceHeaderSizable
        space?.willDisplayHeader(view: view)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceHeaderSizable
        space?.didEndDisplayingHeader(view: view)
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceFooterConfigurable
    typealias Footer = SwiftTableSpaceFooterConfigurable
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceFooterConfigurable
        return space?.footerView(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceFooterSizable {
            return space.estimatedFooterHeight(for: tableView)
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceFooterSizable {
            return space.footerHeight(for: tableView)
        } else {
            return CGFloat.leastNonzeroMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceFooterSizable
        space?.willDisplayFooter(view: view)
    }

    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceFooterSizable
        space?.didEndDisplayingFooter(view: view)
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSpaceInteractable
    typealias CellInteractable = SwiftTableSpaceCellInteractable
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? CellInteractable
        space?.willDisplayCell(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? CellInteractable
        space?.didEndDisplayingCell(cell: cell, at: indexPath, in: tableView)
    }
}

extension SwiftTableSpaceDelegate {
    
    // MARK: SwiftTableSapceActionable
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? SwiftTableSpaceActionable
        space?.accessoryButtonTappedAt(indexPath: indexPath, in: tableView)
    }
}
