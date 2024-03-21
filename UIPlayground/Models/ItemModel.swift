//
//  ItemModel.swift
//  UIPlayground
//
//  Created by Suguru Tokuda on 3/20/24.
//

import Foundation

struct ItemModel: Decodable {
    var id: UUID = UUID()
    let itemName: String
    let itemPrice: Double
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case itemName,
             itemPrice,
             imageURL
    }    
}
