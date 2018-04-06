//
//  SwiftTableSpaceDelegateTests.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 3/23/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftTableSpaces

class SwiftTableSpaceDelegateTests: QuickSpec {
    override func spec() {
        
        describe("Delegate") {
            var sut: SwiftTableSpaceDelegate!
            beforeEach {
                sut = SwiftTableSpaceDelegate()
            }
            
            context("willSelectRow", {
                
                context("nil spaceSource", {
                    
                    beforeEach {
                        sut.spaceSource = nil
                    }
                    
                    it("returns supplied indexPath", closure: {
                        let indexPath = IndexPath(row: 0, section: 1)
                        let received = sut.tableView(UITableView(), willSelectRowAt: indexPath)
                        expect(received).to(equal(indexPath))
                    })
                })
                
                context("non nil spaceSource", {
                    var source: SwiftTableSpaceSourceDouble!
                    
//                    it("fatal if out of range", closure: {
//                        let space = SwiftTableSpaceDouble(numberOfRows: 1)
//                        source = SwiftTableSpaceSourceDouble(spaces: [space])
//                        sut.spaceSource = source
//                        let spaceCount = source.spaces.count
//                        let indexPath = IndexPath(row: 0, section: spaceCount + 1)
////                        sut.tableView(UITableView(), willSelectRowAt: indexPath)\
//                        let call: () -> () = {
//                            _ = sut.tableView(UITableView(), willSelectRowAt: indexPath)
//                        }
//                        expect(call()).to(throwAssertion())
//                    })
                })   
            })
        }
    }
}
