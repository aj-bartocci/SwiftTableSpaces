//
//  SwiftTableSpaceManagerTests.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 3/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftTableSpaces

class SwiftTableSpaceManagerTests: QuickSpec {

    override func spec() {
        
        var interactor: SwiftTableSpaceSourceDouble!
        var tableView: UITableView!
        var sut: SwiftTableSpaceManager!
        beforeEach {
            tableView = UITableView()
            let space = SwiftTableSpaceDouble(numberOfRows: 0)
            interactor = SwiftTableSpaceSourceDouble(spaces: [space])
            sut = SwiftTableSpaceManager(tableView: tableView, interactor: interactor)
        }
        context("on initialization", {
            it("has nil keyboard delegate", closure: {
                expect(sut.keyboardDelegate).to(beNil())
            })
            
            it("calls register cells", closure: {
                expect(interactor.calledRegisterCells).to(equal(true))
            })
            
            it("sets tableview data source", closure: {
                expect(tableView.dataSource).toNot(beNil())
                expect(sut.dataSource.spaceSource) === interactor
            })
            
            it("sets tableview delegate", closure: {
                expect(tableView.delegate).toNot(beNil())
                expect(sut.delegate.spaceSource) === interactor
            })
        })
        describe("KeyboardListener") {
            it("sets delegate", closure: {
                let delegate = KeyboardListenerDelegateConformer()
                sut.keyboardDelegate = delegate
                expect(sut.keyboardListener.delegate) === delegate
                expect(sut.keyboardDelegate) === delegate
            })
        }
    }
}
