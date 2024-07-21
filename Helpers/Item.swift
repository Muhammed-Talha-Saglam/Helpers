//
//  Item.swift
//  Helpers
//
//  Created by Muhammed Talha Sağlam on 21.07.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
