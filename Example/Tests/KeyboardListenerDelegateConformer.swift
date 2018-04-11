//
//  KeyboardListenerDelegateConformer.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 4/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftTableSpaces

class KeyboardListenerDelegateConformer: SwiftTableSpaceKeyboardListenerDelegate {
    
    struct WillEvent {
        let size: CGSize
        let curve: UIViewAnimationCurve
        let duration: Double
    }
    
    var willShowModel: WillEvent? = nil
    var willHideModel: WillEvent? = nil
    var didHideSize: CGSize? = nil
    var didShowSize: CGSize? = nil
    
    func keyboardDidHide(size: CGSize) {
        didHideSize = size
    }
    
    func keyboardDidShow(size: CGSize) {
        didShowSize = size
    }
    
    func keyboardWillShow(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) {
        willShowModel = WillEvent(size: size, curve: animationCurve, duration: duration)
    }
    
    func keyboardWillHide(size: CGSize, animationCurve: UIViewAnimationCurve, duration: Double) {
        willHideModel = WillEvent(size: size, curve: animationCurve, duration: duration)
    }
}

