//
//  ToDoViewController.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftTableSpaces

class ToDoViewController: ToDoBaseViewController {
    
    private var manager: SwiftTableSpaceManager<ToDoTableViewInteractor>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let interactor = ToDoTableViewInteractor()
        self.manager = SwiftTableSpaceManager(tableView: self.tableView, interactor: interactor)
        self.manager.keyboardDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    override func addToDo() {
        guard let text = inputField.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        self.manager.interactor.addToDo(text: text, tableView: self.tableView)
    }
}

extension ToDoViewController: SwiftTableSpaceKeyboardListenerDelegate {
    
    func keyboardWillShow(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) {
        let tableViewBottom = self.tableView.frame.origin.y + self.tableView.frame.height
        let keyboardTop = self.view.frame.height - size.height
        let overlap = tableViewBottom - keyboardTop
        if overlap > 0 {
            self.tableView.contentInset.bottom = overlap
            self.tableView.scrollIndicatorInsets.bottom = overlap
        }
    }
    
    func keyboardWillHide(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) {
        self.tableView.contentInset.bottom = 0.0
        self.tableView.scrollIndicatorInsets.bottom = 0.0
    }
}
