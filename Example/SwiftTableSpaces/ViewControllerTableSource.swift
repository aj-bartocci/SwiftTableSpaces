//
//  ViewControllerTableSource.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ViewControllerTableSource: SwiftTableSpaceInteractor {
    
    
    private var spaces: [SwiftTableSpaceable] = []
    private var stringSpace = ExampleDefaultTableSpace(models: [])
    private var selectSpace = ExampleSelectableTableSpace(models: [])
    private var nonSelectSpace = ExampleNonSelectableTableSpace(models: [])
    
    init() {
        self.setModelsForNonSelectableSpace(["non selctable 1", "non selctable 2","non selctable 3","non selctable 4"])
        let headerSpace = ExampleHeaderTableSpace(models: ["Some header space cell one", "Some header space cell two"])
        self.selectSpace.setModels(["selectable title one", "selectable title two", "selectable title three"])
        self.selectSpace.delegate = self
        self.spaces = [headerSpace, stringSpace, nonSelectSpace, selectSpace]
    }
    
    func setModelsForStringSpace(_ models: [String]) {
        self.stringSpace.setModels(models)
    }
    
    func setModelsForNonSelectableSpace(_ models: [String]) {
        self.nonSelectSpace.setModels(models)
    }
    
    func numberOfSpaces(in tableView: UITableView) -> Int {
        return self.spaces.count
    }
    
    func space(in tableView: UITableView, for index: Int) -> SwiftTableSpaceable {
        return self.spaces[index]
    }
    
    func register(for tableView: UITableView) {
        for space in spaces {
            space.register(for: tableView)
        }
    }
}

extension ViewControllerTableSource: ExampleSelectableTableSpaceDelegate {
    func didSelectCellWith(title: String) {
        print("did select cell with title: \(title)")
    }
}
