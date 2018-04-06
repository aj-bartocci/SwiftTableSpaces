//
//  DelegateConformingTests.swift
//  SwiftTableSpaces_Tests
//
//  Created by AJ Bartocci on 3/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import SwiftTableSpaces

class SwiftTableSpaceDelegateConformingTests: QuickSpec {
    
    override func spec() {
        
        describe("Delegate") {
            var sut: SwiftTableSpaceDelegate!
            var source: SwiftTableSpaceSourceDouble!
            beforeEach {
                sut = SwiftTableSpaceDelegate()
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
                
                describe("Footer Configurable", {
                    it("returns supplied footer view", closure: {
                        let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
                        spaceOne.footer = view
                        testFooterInSection(0, equals: view)
                        
                        let viewTwo = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
                        spaceTwo.footer = viewTwo
                        testFooterInSection(1, equals: viewTwo)
                    })
                    func testFooterInSection(_ section: Int, equals view: UITableViewHeaderFooterView) {
                        let footer = sut.tableView(UITableView(), viewForFooterInSection: section)
                        expect(footer) == view
                    }
                    
                    it("returns supplied footerHeight", closure: {
                        let height: CGFloat = 10.0
                        spaceOne.footerHeight = height
                        testFooterHeightInSection(0, equals: height)
                        
                        let heightTwo: CGFloat = 15.0
                        spaceTwo.footerHeight = heightTwo
                        testFooterHeightInSection(1, equals: heightTwo)
                    })
                    func testFooterHeightInSection(_ section: Int, equals height: CGFloat) {
                        let received = sut.tableView(UITableView(), heightForFooterInSection: section)
                        expect(height) == received
                    }
                    
                    it("returns supplied estimatedFooterHeight", closure: {
                        let height: CGFloat = 10.0
                        spaceOne.estimatedFooterHeight = height
                        testEstimatedHeightInSection(0, equals: height)
                        
                        let heightTwo: CGFloat = 15.0
                        spaceTwo.estimatedFooterHeight = heightTwo
                        testEstimatedHeightInSection(1, equals: heightTwo)
                    })
                    func testEstimatedHeightInSection(_ section: Int, equals height: CGFloat) {
                        let received = sut.tableView(UITableView(), estimatedHeightForFooterInSection: section)
                        expect(received) == height
                    }
                })
                
                describe("Header Configurable", {
                    it("returns supplied header view", closure: {
                        let view = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
                        spaceOne.header = view
                        testHeaderInSection(0, equals: view)
                        
                        let viewTwo = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
                        spaceTwo.header = viewTwo
                        testHeaderInSection(1, equals: viewTwo)
                    })
                    func testHeaderInSection(_ section: Int, equals view: UITableViewHeaderFooterView) {
                        let received = sut.tableView(UITableView(), viewForHeaderInSection: section)
                        expect(received) == view
                    }
                    it("returns supplied headerHeight", closure: {
                        let height: CGFloat = 10.0
                        spaceOne.headerHeight = height
                        testHeaderHeightInSection(0, equals: height)
                        
                        let heightTwo: CGFloat = 15.0
                        spaceTwo.headerHeight = heightTwo
                        testHeaderHeightInSection(1, equals: heightTwo)
                    })
                    func testHeaderHeightInSection(_ section: Int, equals height: CGFloat) {
                        let received = sut.tableView(UITableView(), heightForHeaderInSection: section)
                        expect(received) == height
                    }
                    it("returns supplied estimatedHeaderHeight", closure: {
                        let height: CGFloat = 10.0
                        spaceOne.estimatedHeaderHeight = height
                        testEstimatedHeaderHeightForSection(0, equals: height)
                        
                        let heightTwo: CGFloat = 15.0
                        spaceTwo.estimatedHeaderHeight = heightTwo
                        testEstimatedHeaderHeightForSection(1, equals: heightTwo)
                    })
                    func testEstimatedHeaderHeightForSection(_ section: Int, equals height: CGFloat) {
                        let received = sut.tableView(UITableView(), estimatedHeightForHeaderInSection: section)
                        expect(received) == height
                    }
                })
                
                describe("Deselectable", {
                    beforeEach {
                        spaceOne.shouldDeselectIndexPath = nil
                    }
                    
                    it("supplies correct IndexPath to shouldDeselectCell", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), willDeselectRowAt: indexPath)
                        // expecting it to pass from delegate 
                        expect(indexPath) == spaceOne.shouldDeselectIndexPath
                        // expecting it to return through delegate
                        expect(indexPath) == received
                    })
                    
                    it("calls didDeselectCell", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        sut.tableView(UITableView(), didDeselectRowAt: indexPath)
                        expect(indexPath) == spaceOne.didCallDeselectIndexPath
                    })
                })
                
                describe("Selectable", {
                    beforeEach {
                        spaceOne.shouldSelectIndexPath = nil
                    }
                    
                    it("supplies correct IndexPath to shouldSelectCell", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), willSelectRowAt: indexPath)
                        // expecting it to pass from delegate
                        expect(indexPath) == spaceOne.shouldSelectIndexPath
                        // expecting return through delegate
                        expect(indexPath) == received
                    })
                    
                    it("calls didSelectCell", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        sut.tableView(UITableView(), didSelectRowAt: indexPath)
                        expect(spaceOne.didCallSelectIndexPath) == indexPath
                    })
                })
            })
            
            context("Not Conforming", {
                
                var source: SwiftTableSpaceSourceDouble!
                beforeEach {
                    let space = SwiftTableSpaceDouble(numberOfRows: 1)
                    source = SwiftTableSpaceSourceDouble(spaces: [space])
                    sut.spaceSource = source
                }
                
                describe("Selectable", {
                    it("willSelect returns supplied indexPath", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), willSelectRowAt: indexPath)
                        expect(received) == indexPath
                    })
                })
                
                describe("Deselectable", {
                    it("willDeselect returns supplied indexPath", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), willDeselectRowAt: indexPath)
                        expect(received) == indexPath
                    })
                })
                
                describe("HeaderConfigurable", {
                    it("returns Automatic for estimatedHeight", closure: {
                        let estimate = sut.tableView(UITableView(), estimatedHeightForHeaderInSection: 0)
                        expect(estimate) == UITableViewAutomaticDimension
                    })
                    
                    it("returns leastNonZero for headerHeight", closure: {
                        let height = sut.tableView(UITableView(), heightForHeaderInSection: 0)
                        expect(height) == CGFloat.leastNonzeroMagnitude
                    })
                    
                    it("returns nil header", closure: {
                        let header = sut.tableView(UITableView(), viewForHeaderInSection: 0)
                        expect(header).to(beNil())
                    })
                })
                
                describe("FooterConfigurable", {
                    it("returns Automatic for estimatedHeight", closure: {
                        let height = sut.tableView(UITableView(), estimatedHeightForFooterInSection: 0)
                        expect(height) == UITableViewAutomaticDimension
                    })
                    it("returns leastNonZero for footerHeight", closure: {
                        let height = sut.tableView(UITableView(), heightForFooterInSection: 0)
                        expect(height) == CGFloat.leastNonzeroMagnitude
                    })
                    it("returns nil footer", closure: {
                        let footer = sut.tableView(UITableView(), viewForFooterInSection: 0)
                        expect(footer).to(beNil())
                    })
                })
            })
        }
    }
}
