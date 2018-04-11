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
                describe("CellSizable", {
                    var indexPathOne: IndexPath!
                    var indexPathTwo: IndexPath!
                    var heightOne: CGFloat!
                    var heightTwo: CGFloat!
                    beforeEach {
                        indexPathOne = IndexPath(row: 2, section: 0)
                        indexPathTwo = IndexPath(row: 1, section: 1)
                        heightOne = 105.6
                        heightTwo = 24
                    }
                    it("returns supplied value for cellHeight", closure: {
                        spaceOne.cellHeight = heightOne
                        spaceTwo.cellHeight = heightTwo
                        
                        testCellHeight(for: indexPathOne, equals: heightOne)
                        testCellHeight(for: indexPathTwo, equals: heightTwo)
                    })
                    func testCellHeight(for indexPath: IndexPath, equals height: CGFloat) {
                        let received = sut.tableView(UITableView(), heightForRowAt: indexPath)
                        expect(received) == height
                    }
                    it("returns supplied value for estimatedCellHeight", closure: {
                        spaceOne.estimatedCellHeight = heightOne
                        spaceTwo.estimatedCellHeight = heightTwo
                        
                        testEstimatedCellHeight(for: indexPathOne, equals: heightOne)
                        testEstimatedCellHeight(for: indexPathTwo, equals: heightTwo)
                    })
                    func testEstimatedCellHeight(for indexPath: IndexPath, equals height: CGFloat) {
                        let received = sut.tableView(UITableView(), estimatedHeightForRowAt: indexPath)
                        expect(received) == height
                    }
                })
                describe("Editable", {
                    var indexPathOne: IndexPath!
                    var indexPathTwo: IndexPath!
                    beforeEach {
                        indexPathOne = IndexPath(row: 2, section: 0)
                        indexPathTwo = IndexPath(row: 1, section: 1)
                    }
                    it("returns supplied titleForDelete", closure: {
                        let titleOne = "title one"
                        let titleTwo = "title two"
                        spaceOne.titleForDeleteButton = titleOne
                        spaceTwo.titleForDeleteButton = titleTwo
                        
                        testTitleForDeleteButton(at: indexPathOne, equals: titleOne)
                        testTitleForDeleteButton(at: indexPathTwo, equals: titleTwo)
                    })
                    func testTitleForDeleteButton(at indexPath: IndexPath, equals title: String) {
                        let received = sut.tableView(UITableView(), titleForDeleteConfirmationButtonForRowAt: indexPath)
                        expect(received) == title
                    }
                    it("calls didEndEditing", closure: {
                        spaceOne.didEndEditIndexPath = nil
                        spaceTwo.didEndEditIndexPath = nil
                        
                        testDidEndEditing(indexPath: indexPathOne, space: spaceOne)
                        testDidEndEditing(indexPath: indexPathTwo, space: spaceTwo)
                    })
                    func testDidEndEditing(indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), didEndEditingRowAt: indexPath)
                        expect(space.didEndEditIndexPath) == indexPath
                    }
                    it("calls willBeginEditing", closure: {
                        spaceOne.willBeginEditIndexPath = nil
                        spaceTwo.willBeginEditIndexPath = nil
                        
                        testWillBeginEditing(indexPath: indexPathOne, space: spaceOne)
                        testWillBeginEditing(indexPath: indexPathTwo, space: spaceTwo)
                    })
                    func testWillBeginEditing(indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), willBeginEditingRowAt: indexPath)
                        expect(space.willBeginEditIndexPath) == indexPath
                    }
                    it("passes indexPath to editActionsForRow", closure: {
                        spaceOne.editActionsIndexPath = nil
                        spaceTwo.editActionsIndexPath = nil 
                        
                        testEditActionsFor(indexPath: indexPathOne, space: spaceOne)
                        testEditActionsFor(indexPath: indexPathTwo, space: spaceTwo)
                    })
                    func testEditActionsFor(indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), editActionsForRowAt: indexPath)
                        expect(space.editActionsIndexPath) == indexPath
                    }
                    it("passes through editingStyleForRow", closure: {
                        spaceOne.editingStyleIndexPath = nil
                        spaceTwo.editingStyleIndexPath = nil
                        
                        testEditingStyleFor(indexPath: indexPathOne, space: spaceOne)
                        testEditingStyleFor(indexPath: indexPathTwo, space: spaceTwo)
                    })
                    func testEditingStyleFor(indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), editingStyleForRowAt: indexPath)
                        expect(space.editingStyleIndexPath) == indexPath
                    }
                })
                
                describe("Highlightable", {
                    
                    var indexPathOne: IndexPath!
                    var indexPathTwo: IndexPath!
                    beforeEach {
                        indexPathOne = IndexPath(row: 2, section: 0)
                        indexPathTwo = IndexPath(row: 1, section: 1)
                    }
                    
                    it("passes indexPath to shouldHighlightCell", closure: {
                        spaceOne.shouldHighlightIndexPath = nil
                        spaceTwo.shouldHighlightIndexPath = nil
                        
                        testShouldHighlightCell(at: indexPathOne, space: spaceOne)
                        testShouldHighlightCell(at: indexPathTwo, space: spaceTwo)
                    })
                    func testShouldHighlightCell(at indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        _ = sut.tableView(UITableView(), shouldHighlightRowAt: indexPath)
                        expect(space.shouldHighlightIndexPath) == indexPath
                    }
                    it("passes indexPath to didHighlightCell", closure: {
                        spaceOne.didHighlightIndexPath = nil
                        spaceTwo.didHighlightIndexPath = nil
                        
                        testDidHighlightCell(at: indexPathOne, space: spaceOne)
                        testDidHighlightCell(at: indexPathTwo, space: spaceTwo)
                    })
                    func testDidHighlightCell(at indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), didHighlightRowAt: indexPath)
                        expect(space.didHighlightIndexPath) == indexPath
                    }
                    it("passes indexPath to didUnhighlightCell", closure: {
                        spaceOne.didUnhighlightIndexPath = nil
                        spaceTwo.didUnhighlightIndexPath = nil
                        
                        testDidUnhighlightCell(at: indexPathOne, space: spaceOne)
                        testDidUnhighlightCell(at: indexPathTwo, space: spaceTwo)
                    })
                    func testDidUnhighlightCell(at indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), didUnhighlightRowAt: indexPath)
                        expect(space.didUnhighlightIndexPath) == indexPath
                    }
                })
                
                describe("Footer Configurable", {
                    it("calls didEndDisplayFooter", closure: {
                        spaceOne.didEndDisplayFooterView = nil
                        spaceTwo.didEndDisplayFooterView = nil
                        
                        let viewOne = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
                        let viewTwo = UIView(frame: CGRect(x: 12, y: 56, width: 100, height: 5.8))
                        
                        testDidEndDisplayFooter(view: viewOne, section: 0, space: spaceOne)
                        testDidEndDisplayFooter(view: viewTwo, section: 1, space: spaceTwo)
                    })
                    func testDidEndDisplayFooter(view: UIView, section: Int, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), didEndDisplayingFooterView: view, forSection: section)
                        expect(space.didEndDisplayFooterView) == view
                    }
                    it("calls willDisplayFooter", closure: {
                        spaceOne.willDisplayFooterView = nil
                        spaceTwo.willDisplayFooterView = nil
                        
                        let viewOne = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
                        let viewTwo = UIView(frame: CGRect(x: 12, y: 56, width: 100, height: 5.8))
                        
                        testWillDisplayFooter(view: viewOne, section: 0, space: spaceOne)
                        testWillDisplayFooter(view: viewTwo, section: 1, space: spaceTwo)
                    })
                    func testWillDisplayFooter(view: UIView, section: Int, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), willDisplayFooterView: view, forSection: section)
                        expect(space.willDisplayFooterView) == view
                    }
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
                    it("calls didEndDisplayHeaderView", closure: {
                        spaceOne.didEndDisplayHeaderView = nil
                        spaceTwo.didEndDisplayHeaderView = nil
                        
                        let viewOne = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 50))
                        let viewTwo = UIView(frame: CGRect(x: 10, y: 30, width: 200, height: 100))
                        
                        testDidEndDisplayHeader(view: viewOne, section: 0, space: spaceOne)
                        testDidEndDisplayHeader(view: viewTwo, section: 1, space: spaceTwo)
                    })
                    func testDidEndDisplayHeader(view: UIView, section: Int, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), didEndDisplayingHeaderView: view, forSection: section)
                        expect(space.didEndDisplayHeaderView) == view
                    }
                    it("calls willDisplayHeaderView", closure: {
                        
                        spaceOne.willDisplayHeaderView = nil
                        spaceTwo.willDisplayHeaderView = nil
                        
                        let viewOne = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
                        let viewTwo = UIView(frame: CGRect(x: 10, y: 20, width: 20, height: 60))
                        
                        testWillDisplayHeader(view: viewOne, section: 0, space: spaceOne)
                        testWillDisplayHeader(view: viewTwo, section: 1, space: spaceTwo)
                    })
                    func testWillDisplayHeader(view: UIView, section: Int, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), willDisplayHeaderView: view, forSection: section)
                        expect(space.willDisplayHeaderView) == view
                    }
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
                describe("Actionable", {
                    it("supplies IndexPath to accessoryButtonTapped", closure: {
                        spaceOne.accessoryButtonIndexPath = nil
                        spaceTwo.accessoryButtonIndexPath = nil
                        
                        let indexPathOne = IndexPath(row: 0, section: 0)
                        let indexPathTwo = IndexPath(row: 0, section: 1)
                        
                        testAccessoryButtonTapped(at: indexPathOne, space: spaceOne)
                        testAccessoryButtonTapped(at: indexPathTwo, space: spaceTwo)
                    })
                    func testAccessoryButtonTapped(at indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), accessoryButtonTappedForRowWith: indexPath)
                        expect(space.accessoryButtonIndexPath) == indexPath
                    }
                })
                describe("CellInteractable", {
                    var cellOne: UITableViewCell!
                    var cellTwo: UITableViewCell!
                    var indexPathOne: IndexPath!
                    var indexPathTwo: IndexPath!
                    beforeEach {
                        cellOne = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "resuse one")
                        indexPathOne = IndexPath(row: 0, section: 0)
                        cellTwo = UITableViewCell(style: .subtitle, reuseIdentifier: "reuse two")
                        indexPathTwo = IndexPath(row: 0, section: 1)
                    }
                    it("calls willDisplayCell", closure: {
                        spaceOne.willDisplayCellIndexPath = nil
                        spaceOne.willDisplayCell = nil
                        spaceTwo.willDisplayCellIndexPath = nil
                        spaceTwo.willDisplayCell = nil
                        
                        testWillDisplayCell(cell: cellOne, indexPath: indexPathOne, space: spaceOne)
                        testWillDisplayCell(cell: cellTwo, indexPath: indexPathTwo, space: spaceTwo)
                    })
                    func testWillDisplayCell(cell: UITableViewCell, indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), willDisplay: cell, forRowAt: indexPath)
                        expect(space.willDisplayCell) == cell
                        expect(space.willDisplayCellIndexPath) == indexPath
                    }
                    it("calls didEndDisplayCell", closure: {
                        spaceOne.didEndDisplayCell = nil
                        spaceOne.didEndDisplayIndexPath = nil
                        spaceTwo.didEndDisplayCell = nil
                        spaceTwo.didEndDisplayIndexPath = nil
                        
                        testDidEndDisplayCell(cell: cellOne, indexPath: indexPathOne, space: spaceOne)
                        testDidEndDisplayCell(cell: cellTwo, indexPath: indexPathTwo, space: spaceTwo)
                    })
                    func testDidEndDisplayCell(cell: UITableViewCell, indexPath: IndexPath, space: SwiftTableSpaceConformingDouble) {
                        sut.tableView(UITableView(), didEndDisplaying: cell, forRowAt: indexPath)
                        expect(space.didEndDisplayIndexPath) == indexPath
                        expect(space.didEndDisplayCell) == cell
                    }
                })
            })
            
            context("Not Conforming", {
                
                var source: SwiftTableSpaceSourceDouble!
                var indexPath: IndexPath!
                beforeEach {
                    indexPath = IndexPath(row: 0, section: 0)
                    let space = SwiftTableSpaceDouble(numberOfRows: 1)
                    source = SwiftTableSpaceSourceDouble(spaces: [space])
                    sut.spaceSource = source
                }
                describe("CellSizable", {
                    it("returns AutomaticDimension for cellHeight", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), heightForRowAt: indexPath)
                        expect(received) == UITableViewAutomaticDimension
                    })
                    it("returns AutomaticDimension for estimatedHeight", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), estimatedHeightForRowAt: indexPath)
                        expect(received) == UITableViewAutomaticDimension
                    })
                })
                describe("Editable", {
                    it("returns nil for deleteTitle", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), titleForDeleteConfirmationButtonForRowAt: indexPath)
                        expect(received).to(beNil())
                    })
                    it("returns nil for editActions", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), editActionsForRowAt: indexPath)
                        expect(received).to(beNil())
                    })
                    it("returns delete for editingStyle", closure: {
                        let received = sut.tableView(UITableView(), editingStyleForRowAt: indexPath)
                        expect(received) == .delete
                    })
                })
                
                describe("Highlightable", {
                    it("returns true for shouldHighlight", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), shouldHighlightRowAt: indexPath)
                        expect(received) == true
                    })
                })
                
                describe("Selectable", {
                    it("returns supplied indexPath willSelect", closure: {
                        let indexPath = IndexPath(row: 0, section: 0)
                        let received = sut.tableView(UITableView(), willSelectRowAt: indexPath)
                        expect(received) == indexPath
                    })
                })
                
                describe("Deselectable", {
                    it("returns supplied indexPath for willDeselect", closure: {
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
