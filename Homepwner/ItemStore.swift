//
//  ItemStore.swift
//  Homepwner
//
//  Created by Sami Taha on 6/13/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit


class ItemStore {
    var allItems = [Item]()
    
    
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        return newItem
        
        
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        /// Get reference to object being moved so you can resinsert it
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
        
    }
}

