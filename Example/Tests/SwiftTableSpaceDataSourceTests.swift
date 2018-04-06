//
//  SwiftTableSpaceDataSourceTests.swift
//  SwiftTableSpaces_Example
//
//  Created by AJ Bartocci on 3/20/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftTableSpaces

class SwiftTableSpaceDataSourceTests: QuickSpec {
    
    override func spec() {
        
        // The tests could be ordered differently to reduce dupe code
        // but splitting each function into it's own 'describe'
        // helps look at all possibilities of a function together
        describe("DataSource") {
            
            var dataSource: SwiftTableSpaceDataSource!
            var spaces: [SwiftTableSpaceable]!
            var spaceSource: SwiftTableSpaceSourceDouble!
            beforeEach {
                dataSource = SwiftTableSpaceDataSource()
                spaces = []
                spaceSource = SwiftTableSpaceSourceDouble(spaces: spaces)
                dataSource.spaceSource = spaceSource
            }
            
            describe("numberOfSections", closure: {
                
                context("with nil spaceSource", {
                    beforeEach {
                       dataSource.spaceSource = nil
                    }
                    
                    it("has 0 sections", closure: {
                        expect(dataSource.numberOfSections(in: UITableView())).to(equal(0))
                    })
                })
                
                context("with non nil spaceSource", {
                    
                    it("has 1 section", closure: {
                        spaces = [SwiftTableSpaceDouble(numberOfRows: 1)]
                        spaceSource.spaces = spaces
                        testSectionCount()
                    })
                    
                    it("has 2 sections", closure: {
                        spaces = [SwiftTableSpaceDouble(numberOfRows: 1),
                                  SwiftTableSpaceDouble(numberOfRows: 1)
                        ]
                        spaceSource.spaces = spaces
                        testSectionCount()
                    })
                    
                    func testSectionCount() {
                        expect(dataSource.numberOfSections(in: UITableView())).to(equal(spaces.count))
                    }
                })
                
            })
            
            describe("numberOfRowsInSection", closure: {
                
                context("with nil spaceSource", {
                    beforeEach {
                        dataSource.spaceSource = nil
                    }
                    
                    it("has 0 rows", closure: {
                        expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).to(equal(0))
                    })
                })
                
                context("with non nil spaceSource", {
                    context("one section", {
                        it("has 1 row", closure: {
                            spaces = [SwiftTableSpaceDouble(numberOfRows: 1)]
                            spaceSource.spaces = spaces
                            expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).to(equal(1))
                        })
                        
                        it("has 2 rows", closure: {
                            spaces = [SwiftTableSpaceDouble(numberOfRows: 2)]
                            spaceSource.spaces = spaces
                            expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 0)).to(equal(2))
                        })
                    })
                    
                    context("multi section", closure: {
                        it("has 1 row", closure: {
                            spaces = [SwiftTableSpaceDouble(numberOfRows: 2),
                                      SwiftTableSpaceDouble(numberOfRows: 1)
                            ]
                            spaceSource.spaces = spaces
                            expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 1)).to(equal(1))
                        })
                        it("has 2 rows", closure: {
                            spaces = [SwiftTableSpaceDouble(numberOfRows: 3),
                                      SwiftTableSpaceDouble(numberOfRows: 2)
                            ]
                            spaceSource.spaces = spaces
                            expect(dataSource.tableView(UITableView(), numberOfRowsInSection: 1)).to(equal(2))
                        })
                    })
                })
            })
            
//            describe("cellForRow", closure: {
//                
//                context("non nil spaceSource", {
//                    
//                })
//            })
        }
    }
}
