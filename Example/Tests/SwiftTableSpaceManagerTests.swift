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
        
        context("on initialization", {
            
            var interactor: SwiftTableSpaceSourceDouble!
            var tableView: UITableView!
            var sut: SwiftTableSpaceManager<SwiftTableSpaceSourceDouble>!
            beforeEach {
                tableView = UITableView()
                let space = SwiftTableSpaceDouble(numberOfRows: 0)
                interactor = SwiftTableSpaceSourceDouble(spaces: [space])
                sut = SwiftTableSpaceManager(tableView: tableView, interactor: interactor)
            }
            
            it("calls register cells", closure: {
                expect(interactor.calledRegisterCells).to(equal(true))
            })
            
            it("sets tableview data source", closure: {
                expect(tableView.dataSource).toNot(beNil())
            })
            
            it("sets tableview delegate", closure: {
                expect(tableView.delegate).toNot(beNil())
            })
        })
    }
}
