//
//  MassiveToDoViewController.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

/*
 !!!!!!!!!!!!!!!!!!!!!!
 
 You should not do this! This is an example showing what can happen when you keep all of the logic in the ViewController.
 
 Don't Do it!
 
 !!!!!!!!!!!!!!!!!!!!!!
 
 */

class MassiveToDoViewController: ToDoBaseViewController {
    
    var toDoArray: [String] = []
    var completedToDoArray: [String] = []
    
    typealias Cell = ToDoTableViewCell
    let cellId = "ToDoTableViewCellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "ToDoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        tableView.tableFooterView = UIView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        let lastIndex = self.toDoArray.count
        let indexPath = IndexPath(row: lastIndex, section: 0)
        self.toDoArray.append(text)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}

extension MassiveToDoViewController {
    
    private func infoFrom(notification: Notification) -> [AnyHashable: Any]? {
        guard let info = notification.userInfo else {
            return nil
        }
        if #available(iOS 9.0, *) {
            // makes sure the notification originated from this app
            guard let isThisApp = info[UIKeyboardIsLocalUserInfoKey] as? NSNumber else {
                return nil
            }
            guard isThisApp.boolValue == true else {
                return nil
            }
        }
        return info
    }
    
    @objc func handleTableViewWillShow(notification: Notification) {
        guard let info = infoFrom(notification: notification) else {
            return
        }
        guard let frameValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        guard let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }
        guard let curveNum = info[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return
        }
        guard let curve = UIViewAnimationCurve(rawValue: curveNum.intValue) else {
            return
        }
        self.keyboardWillShow(size: frameValue.cgRectValue.size, animationCurve: curve, duration: duration.doubleValue)
    }
    
    @objc func handleTableViewWillHide(notification: Notification) {
        guard let info = infoFrom(notification: notification) else {
            return
        }
        guard let frameValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        guard let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }
        guard let curveNum = info[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return
        }
        guard let curve = UIViewAnimationCurve(rawValue: curveNum.intValue) else {
            return
        }
        self.keyboardWillHide(size: frameValue.cgRectValue.size, animationCurve: curve, duration: duration.doubleValue)
    }
    
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

extension MassiveToDoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.toDoArray.count
        } else if section == 1 {
            return self.completedToDoArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! Cell
        let model: String
        if indexPath.section == 0 {
            model = self.toDoArray[indexPath.row]
        } else if indexPath.section == 1 {
            model = self.completedToDoArray[indexPath.row]
        } else {
            model = ""
        }
        cell.setTitle(text: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "ToDos"
        } else if section == 1 {
            return "Completed ToDos"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if indexPath.section == 1 {
                self.completedToDoArray.remove(at: indexPath.row)
            }
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            break
        case .insert:
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            break
        default:
            break
        }
    }
}

extension MassiveToDoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if indexPath.section == 0 {
            let complete = UITableViewRowAction(style: .normal, title: "Complete") { [weak self] (action, indexPath) in
                // remove and call delegate to add to other section
                guard let text = self?.toDoArray.remove(at: indexPath.row) else {
                    return
                }
                self?.tableView(tableView, commit: .delete, forRowAt: indexPath)
                self?.addCompletedToDo(text, tableView: tableView)
            }
            complete.backgroundColor = .green
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
                // delete
                self?.toDoArray.remove(at: indexPath.row)
                self?.tableView(tableView, commit: .delete, forRowAt: indexPath)
            }
            return [delete, complete]
        } else {
            return nil
        }
    }
    
    private func addCompletedToDo(_ text: String, tableView: UITableView) {
        let lastIndex = self.completedToDoArray.count
        let indexPath = IndexPath(row: lastIndex, section: 1)
        self.completedToDoArray.append(text)
        self.tableView(tableView, commit: .insert, forRowAt: indexPath)
    }
}
