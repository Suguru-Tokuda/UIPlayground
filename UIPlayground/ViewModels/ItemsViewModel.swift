//
//  ItemsViewModel.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import Foundation

class ItemsViewModel {
    var items: [ItemModel] = []
    var itemsUpdated: (() -> ())?
    var localDataManager: LocalDataManaging
    let jsonFileName = "itemList"
    
    init(localDataManager: LocalDataManaging = LocalDataManager()) {
        self.localDataManager = localDataManager
    }
    
    func loadItems() {
        do {
            let items = try localDataManager.getData(fileName: jsonFileName, extensionStr: "json", type: [ItemModel].self)
            self.items = items
            itemsUpdated?()
        } catch {
            print(error.localizedDescription)
        }
    }
}
