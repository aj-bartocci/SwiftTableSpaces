# SwiftTableSpaces

[![CI Status](http://img.shields.io/travis/AJ Bartocci/SwiftTableSpaces.svg?style=flat)](https://travis-ci.org/AJ Bartocci/SwiftTableSpaces)
[![Version](https://img.shields.io/cocoapods/v/SwiftTableSpaces.svg?style=flat)](http://cocoapods.org/pods/SwiftTableSpaces)
[![License](https://img.shields.io/cocoapods/l/SwiftTableSpaces.svg?style=flat)](http://cocoapods.org/pods/SwiftTableSpaces)
[![Platform](https://img.shields.io/cocoapods/p/SwiftTableSpaces.svg?style=flat)](http://cocoapods.org/pods/SwiftTableSpaces)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. 

The example app implement a table view that acts as a to do list. A user can add a todo to the list, which adds a cell to the 'ToDos' section. Within the 'ToDos' section users can mark a todo as completed or delete it from the list. When a todo is marked as completed it is added to the 'Completed ToDos' section. A user can then delete completed todos within the 'Completed ToDos' section. 

The example app has 3 tabs the each implement the same ToDo view controller. One tab fully implements SwiftTableSpaces and manages the tableview with a SwiftTableSpaceManager. Another tab does not use SwiftTableSpaces at all and implements all functionality within a massive view controller. The last tab uses SwiftTableSpaces to modularize the tableview sections but does not use the SwiftTableSpaceManager, instead uses the tablespaces with the UITableViewDataSource and the SwiftTableViewDelegate manually. 

* The massive view controller example uses ~ **215 lines** of code inside the view controller class.
* The hybrid example that uses SwiftTableSpaces with the UITableViewDataSource and the SwiftTableViewDelegate manually uses ~ **130 lines** of code inside the view controller class.
* The SwiftTableSpaces with SwiftTableSpaceManager example uses ~ **45 lines** of code inside the view controller class.

## Requirements

A good understanding of how UITableViews work and familiarity with the UITableViewDataSource and SwiftTableViewDelegate

## Installation

SwiftTableSpaces is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftTableSpaces'
```

## Usage 
SwiftTableSpaces are classes that conform to the SwiftTableSpaceable protocol. A class conforming to SwiftTableSpaceable must implement three functions:

```swift
func register(for tableView: UITableView)
```
This function should be used to register any nibs or classes that will be presented by the tableview

```swift
func numberOfRows() -> Int
```
This function returns the number of rows in the particular table space. This is wrapping the UITableViewDataSource function tableView(UITableView, numberOfRowsInSection: Int) -> Int

```swift
func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
```
This function returns the cell for the specified indexpath. This is where any configuration of the cell would be done. This is wrapping the UITableViewDataSource function tableView(_ tableView: UITableView, 
  cellForRowAt indexPath: IndexPath) -> UITableViewCell

![alt text](https://github.com/aj-bartocci/SwiftTableSpaces/blob/master/Example/Assets/TableSpaceDetailed.png?raw=true)

The example above illistrates what SwiftTableSpaces do. There are two sections in the tableview, each section is configured by a tablespace. A custom base TableSpace is created named 'StringTableSpace' that configures cells using a string for each cell. TableSpaceOne and TableSpaceTwo each subclass the StringTableSpace class. 

The base string table space class: 

```swift
import SwiftTableSpaces

class StringTableSpace: SwiftTableSpaceable {
    
    typealias Model = String
    typealias Cell = TableSpaceTableViewCell
    let cellId = "TableSpaceTableViewCellId"
    private (set) var models: [Model] = []
    
    func setModels(_ models: [Model]) {
        self.models = models
    }
    
    func numberOfRows() -> Int {
        return models.count
    }
    
    func register(for tableView: UITableView) {
        let nib = UINib(nibName: "TableSpaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! Cell
        let model = models[indexPath.row]
        cell.titleLabel.text = model
        return cell 
    }
}
```

TableSpaceOne class: 

```swift
import SwiftTableSpaces

class TableSpaceOne: StringTableSpace {
    
    override func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = super.cell(forRowAt: indexPath, in: tableView) as! Cell
        cell.titleLabel.textAlignment = .left
        cell.titleLabel.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
}

extension TableSpaceOne: SwiftTableSpaceDefaultHeaderTitleable {
    
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return 25.0
    }
    
    func titleForDefaultHeader(in tableView: UITableView) -> String? {
        return "Space One Default Header"
    }
}

extension TableSpaceOne: SwiftTableSpaceDefaultFooterTitleable {
    func estimatedFooterHeight(for tableView: UITableView) -> CGFloat {
        return 25.0
    }
    
    func titleForDefaultFooter(in tableView: UITableView) -> String? {
        return "Space One Default Footer"
    }
}
```

TableSpaceTwo class:

```swift
import SwiftTableSpaces

class TableSpaceTwo: StringTableSpace {
    
    typealias Header = ExampleHeaderFooterView
    let headerId = "ExampleHeaderFooterViewId"
    
    override func cell(forRowAt indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = super.cell(forRowAt: indexPath, in: tableView) as! Cell
        cell.titleLabel.textAlignment = .right
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return cell
    }
    
    override func register(for tableView: UITableView) {
        super.register(for: tableView)
        let nib = UINib(nibName: "ExampleHeaderFooterView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }
    
}

extension TableSpaceTwo: SwiftTableSpaceHeaderConfigurable {
    
    func headerView(for tableView: UITableView) -> UITableViewHeaderFooterView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? Header
        header?.titleLabel.text = "Space Two Custom Header View With Long Title To Run Multiple Lines"
        header?.contentView.backgroundColor = .white 
        return header
    }
    
    func estimatedHeaderHeight(for tableView: UITableView) -> CGFloat {
        return 80.0
    }
}
```

The two tablespaces subclass StringTableSpace but conform to different protocols that alter their appearance. TableSpaceOne implements SwiftTableSpaceDefaultHeaderTitleable and SwiftTableSpaceDefaultFooterTitleable protocols, and left aligns the cell text. TableSpaceTwo implements the SwiftTableSpaceHeaderConfigurable protocol and aligns the text in the cell to the right and bolds the font. 

The UITableViewDataSource and UITableViewDelegate functionality has been split into smaller logically related protocols that make it obvious exactly what that tablespace is supposed to do.  SwiftTableSpaceDefaultHeaderTitleable, SwiftTableSpaceDefaultFooterTitleable, and SwiftTableSpaceHeaderConfigurable are examples of this.

## Author

AJ Bartocci, bartocci.aj@gmail.com

## License

SwiftTableSpaces is available under the MIT license. See the LICENSE file for more info.
