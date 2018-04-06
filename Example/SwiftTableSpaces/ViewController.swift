//
//  ViewController.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 03/20/2018.
//  Copyright (c) 2018 AJ Bartocci. All rights reserved.
//

import UIKit
import SwiftTableSpaces

// TODO: add a way to set the cell heights explicitly?

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var manager: SwiftTableSpaceManager<ViewControllerTableSource>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        let source = ViewControllerTableSource()
        self.manager = SwiftTableSpaceManager(tableView: self.tableView, interactor: source)
        
        self.manager.interactor.setModelsForStringSpace(["one", "two", "three that is really long and should automatically resize to fit the label inside the bounds", "four"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

