//
//  ExampleDefaultTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/5/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ExampleDefaultTableSpace: SwiftTableSpaceable {
    
    typealias Model = String
    typealias Cell = ExampleTableViewCell
    private let cellId = "ExampleTableViewCellId"
    
    fileprivate (set) var models: [Model] = []
    init(models: [Model]) {
        self.models = models
    }
    
    func setModels(_ models: [Model]) {
        self.models = models
    }
    
    func numberOfRows() -> Int {
        return self.models.count
    }
    
    func register(for tableView: UITableView) {
        let nib = UINib(nibName: "ExampleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! Cell
        let model = self.models[indexPath.row]
        cell.setTitle(model)
        return cell
    }
}
