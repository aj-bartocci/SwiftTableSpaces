//
//  SwiftTableSpaceKeyboardListenerTests.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 4/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftTableSpaces

class SwiftTableSpaceKeyboardListenerTests: QuickSpec {
    override func spec() {
        
        let sut = SwiftTableSpaceKeyboardListener()
        var listenerDelegate: KeyboardListenerDelegateConformer!
        let rectOne = CGRect(x: 0, y: 0, width: 30, height: 50)
        let rectTwo = CGRect(x: 0, y: 0, width: 10, height: 106)
        
        beforeEach {
            listenerDelegate = KeyboardListenerDelegateConformer()
            sut.delegate = listenerDelegate
        }
        context("Will") {
            describe("willShow", {
                it("sends values", closure: {
                    testWillShowNotification(rect: rectOne, curve: .easeIn, duration: 4.0)
                    testWillShowNotification(rect: rectTwo, curve: .easeOut, duration: 1.4)
                })
            })
            func testWillShowNotification(rect: CGRect, curve: UIViewAnimationCurve, duration: Double) {
                let notification = createWillNotification(name: .UIKeyboardWillShow, rect: rect, curve: curve, duration: duration)
                sut.handleTableViewWillShow(notification: notification)
                let model = KeyboardListenerDelegateConformer.WillEvent(size: rect.size, curve: curve, duration: duration)
                expect(listenerDelegate.willShowModel?.size) == model.size
                expect(listenerDelegate.willShowModel?.duration) == model.duration
                expect(listenerDelegate.willShowModel?.curve) == model.curve
            }
            describe("willHide", {
                it("sends values", closure: {
                    testWillHideNotification(rect: rectOne, curve: .easeOut, duration: 3.5)
                    testWillHideNotification(rect: rectTwo, curve: .easeIn, duration: 1.2)
                })
            })
            func testWillHideNotification(rect: CGRect, curve: UIViewAnimationCurve, duration: Double) {
                let notification = createWillNotification(name: .UIKeyboardWillHide, rect: rect, curve: curve, duration: duration)
                sut.handleTableViewWillHide(notification: notification)
                let model = KeyboardListenerDelegateConformer.WillEvent(size: rect.size, curve: curve, duration: duration)
                expect(listenerDelegate.willHideModel?.size) == model.size
                expect(listenerDelegate.willHideModel?.duration) == model.duration
                expect(listenerDelegate.willHideModel?.curve) == model.curve
            }
            func createWillNotification(name: Notification.Name, rect: CGRect, curve: UIViewAnimationCurve, duration: Double) -> Notification {
                var notification = createDidNotification(name: name, rect: rect)
                notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] = NSNumber(value: duration)
                notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] = NSNumber(value: curve.rawValue)
                return notification
            }
        }
        context("Did") {
            describe("didHide") {
                it("sends size", closure: {
                    testDidHideNotification(rect: rectOne)
                    testDidHideNotification(rect: rectTwo)
                })
                func testDidHideNotification(rect: CGRect) {
                    let notification = createDidNotification(name: .UIKeyboardDidHide, rect: rect)
                    sut.handleTableViewDidHide(notification: notification)
                    expect(listenerDelegate.didHideSize) == rect.size
                }
            }
            describe("didShow") {
                it("sends size", closure: {
                    testDidShowNotification(rect: rectOne)
                    testDidShowNotification(rect: rectTwo)
                })
                func testDidShowNotification(rect: CGRect) {
                    let notification = createDidNotification(name: .UIKeyboardDidShow, rect: rect)
                    sut.handleTableViewDidShow(notification: notification)
                    expect(listenerDelegate.didShowSize) == rect.size
                }
            }
        }
        func createDidNotification(name: Notification.Name, rect: CGRect) -> Notification {
            let val = NSValue.init(cgRect: rect)
            let info: [AnyHashable: Any] = [UIKeyboardFrameEndUserInfoKey: val]
            var notification = Notification(name: name, object: nil, userInfo: info)
            notification.userInfo?[UIKeyboardIsLocalUserInfoKey] = NSNumber(value: true)
            return notification
        }
    }
}
