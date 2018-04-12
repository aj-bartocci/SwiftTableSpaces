//
//  ToDoBaseTableSpace.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftTableSpaces

class ToDoBaseTableSpace: NSObject, SwiftTableSpaceable {
    
    typealias Cell = ToDoTableViewCell
    private let cellId = "ToDoTableViewCellId"
    
    typealias Model = String
    private (set) var models: [Model]
    
    override init() {
        self.models = []
        super.init()
    }
    
    func numberOfRows() -> Int {
        return self.models.count
    }
    
    func register(for tableView: UITableView) {
        let nib = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.cellId)
    }
    
    func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! Cell
        let model = self.models[indexPath.row]
        cell.setTitle(text: model)
        return cell
    }
    
    func addModel(_ model: Model) {
        self.models.append(model)
    }
    
    func removeModel(at index: Int) {
        self.models.remove(at: index)
    }
}
