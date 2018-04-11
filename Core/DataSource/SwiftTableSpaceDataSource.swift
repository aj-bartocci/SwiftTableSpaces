//
//  SwiftTableSpaceDataSource.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

class SwiftTableSpaceDataSource: NSObject, UITableViewDataSource {
    
    weak var spaceSource: SwiftTableSpaceSource?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return spaceSource?.numberOfSpaces(in: tableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let space = spaceSource?.space(in: tableView, for: section)
        return space?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let space = spaceSource?.space(in: tableView, for: indexPath.section)
        // should this really throw an error?
        return space?.cell(forRowAt: indexPath, in: tableView) ?? UITableViewCell()
    }
    
    // ----------------
    
    //    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    //
    //    }
    //
    //    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //
    //    }
    //
    //    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    //
    //    }
    //
    //    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //
    //    }
}

extension SwiftTableSpaceDataSource {
    // MARK: Editing
    
    typealias Editable = SwiftTableSpaceEditable
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Editable {
            return space.canEditRow(at: indexPath, in: tableView)
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let space = spaceSource?.space(in: tableView, for: indexPath.section) as? Editable
        space?.commitEditing(style: editingStyle, forRowAt: indexPath)
    }
}

extension SwiftTableSpaceDataSource {
    // MARK: Default titles for header footer
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceDefaultHeaderTitleable
        return space?.titleForDefaultHeader(in: tableView)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let space = spaceSource?.space(in: tableView, for: section) as? SwiftTableSpaceDefaultFooterTitleable
        return space?.titleForDefaultFooter(in: tableView)
    }
}
