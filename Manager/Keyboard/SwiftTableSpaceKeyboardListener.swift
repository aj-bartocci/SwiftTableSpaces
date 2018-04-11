//
//  SwiftTableSpaceKeyboardListener.swift
//  SwiftTableSpaces
//
//  Created by AJ Bartocci on 3/20/18.
//

import UIKit

public protocol SwiftTableSpaceKeyboardListenerDelegate: class {
    func keyboardWillShow(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double)
    func keyboardDidShow(size: CGSize)
    func keyboardWillHide(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double)
    func keyboardDidHide(size: CGSize)
}

public extension SwiftTableSpaceKeyboardListenerDelegate {
    func keyboardDidShow(size: CGSize) { }
    func keyboardDidHide(size: CGSize) { }
    func keyboardWillShow(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) { }
    func keyboardWillHide(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) { }
    
}

class SwiftTableSpaceKeyboardListener: NSObject {
        
    weak var delegate: SwiftTableSpaceKeyboardListenerDelegate?
    
    override init() {
        super.init()
//        Notification.Name.UIKeyboardWillChangeFrame
        self.setupObservers()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewDidShow(notification:)), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTableViewDidHide(notification:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
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
        self.delegate?.keyboardWillShow(size: frameValue.cgRectValue.size, animationCurve: curve, duration: duration.doubleValue)
    }
    
    @objc func handleTableViewDidShow(notification: Notification) {
        guard let info = infoFrom(notification: notification) else {
            return
        }
        guard let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        delegate?.keyboardDidShow(size: value.cgRectValue.size)
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
        self.delegate?.keyboardWillHide(size: frameValue.cgRectValue.size, animationCurve: curve, duration: duration.doubleValue)
    }
    
    @objc func handleTableViewDidHide(notification: Notification) {
        guard let info = infoFrom(notification: notification) else {
            return
        }
        guard let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        delegate?.keyboardDidHide(size: value.cgRectValue.size)
    }
}
