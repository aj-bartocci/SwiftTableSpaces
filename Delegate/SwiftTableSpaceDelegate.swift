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
    
    // MARK: SwiftTableSpaceHeaderConfigurable
    typealias Header = SwiftTableSpaceHeaderConfigurable
    
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
        let space = spaceSource?.space(in: tableView, for: section) as? Header
        return space?.headerView(for: tableView)
    }
}

extension SwiftTableSpaceDelegate {
    // MARK: HeaderDisplayable 
    //
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //
    //    }
    //
    //    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
    //
    //    }
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
    
//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//
//    }
//
//    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
//
//    }
}
