//
//  DataSourceConformingTests.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 4/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftTableSpaces

class SwiftTableSpaceDataSourceConformingTests: QuickSpec {
    
    override func spec() {
        describe("DataSource") {
            var sut: SwiftTableSpaceDataSource!
            var source: SwiftTableSpaceSourceDouble!
            beforeEach {
                sut = SwiftTableSpaceDataSource()
                source = SwiftTableSpaceSourceDouble(spaces: [])
            }

            context("Conforming", {
                var spaceOne: SwiftTableSpaceConformingDouble!
                var spaceTwo: SwiftTableSpaceConformingDouble!
                beforeEach {
                    spaceOne = SwiftTableSpaceConformingDouble(numberOfRows: 1)
                    spaceTwo = SwiftTableSpaceConformingDouble(numberOfRows: 1)
                    source = SwiftTableSpaceSourceDouble(spaces: [spaceOne, spaceTwo])
                    sut.spaceSource = source
                }
                describe("FooterDefaultTitleable", {
                    it("passes title through delegate", closure: {
                        let footerOne = "footerOne"
                        let footerTwo = "footerTwo"
                        
                        spaceOne.defaultFooterTitle = footerOne
                        spaceTwo.defaultFooterTitle = footerTwo
                        
                        testTitleForFooterInSection(0, equals: footerOne)
                        testTitleForFooterInSection(1, equals: footerTwo)
                    })
                    func testTitleForFooterInSection(_ section: Int, equals title: String) {
                        let footer = sut.tableView(UITableView(), titleForFooterInSection: section)
                        expect(footer) == title
                    }
                })
                
                describe("HeaderDefaultTitleable", {
                    it("passes title through delegate", closure: {
                        let headerOne = "headerOne"
                        let headerTwo = "headerTwo"
                        
                        spaceOne.defaultHeaderTitle = headerOne
                        spaceTwo.defaultHeaderTitle = headerTwo
                        
                        testTitleForHeaderInSection(0, equals: headerOne)
                        testTitleForHeaderInSection(1, equals: headerTwo)
                    })
                    func testTitleForHeaderInSection(_ section: Int, equals title: String) {
                        let header = sut.tableView(UITableView(), titleForHeaderInSection: section)
                        expect(header) == title
                    }
                })
                
                describe("Editable", {
                    it("returns supplied value for canEdit", closure: {
                        spaceOne.canEdit = true
                        spaceTwo.canEdit = false
                        
                        testCanEdit(returns: true, for: IndexPath(row: 0, section: 0))
                        testCanEdit(returns: false, for: IndexPath(row: 0, section: 1))
                    })
                    func testCanEdit(returns canEdit: Bool, for indexPath: IndexPath) {
                        let received = sut.tableView(UITableView(), canEditRowAt: indexPath)
                        expect(received) == canEdit
                    }
                    
                    it("passes editing style through delegate", closure: {
                        spaceOne.editingStyle = nil
                        spaceTwo.editingStyle = nil
                        
                        let editOne = UITableViewCellEditingStyle.insert
                        let editTwo = UITableViewCellEditingStyle.delete
                        
                        sut.tableView(UITableView(), commit: editOne, forRowAt: IndexPath(row: 0, section: 0))
                        sut.tableView(UITableView(), commit: editTwo, forRowAt: IndexPath(row: 0, section: 1))
                        
                        expect(spaceOne.editingStyle) == editOne
                        expect(spaceTwo.editingStyle) == editTwo
                    })
                })
                
            })
            
            context("Not Conforming", {
                beforeEach {
                    let space = SwiftTableSpaceDouble(numberOfRows: 1)
                    source = SwiftTableSpaceSourceDouble(spaces: [space])
                    sut.spaceSource = source
                }
                describe("FooterDefaultTitleable", {
                    it("returns nil", closure: {
                        let title = sut.tableView(UITableView(), titleForFooterInSection: 0)
                        expect(title).to(beNil())
                    })
                })
                describe("HeaderDefaultTitleable", {
                    it("returns nil", closure: {
                        let title = sut.tableView(UITableView(), titleForHeaderInSection: 0)
                        expect(title).to(beNil())
                    })
                })
                describe("Editable", {
                    it("returns false for canEdit", closure: {
                        let canEdit = sut.tableView(UITableView(), canEditRowAt: IndexPath(row: 0, section: 0))
                        expect(canEdit) == false
                    })
                })
            })
        }
    }
}
