//
//  Collections+Indexed.swift
//  Helpers
//
//  Created by Muhammed Talha Sağlam on 30.07.2024.
//

import Foundation

extension RandomAccessCollection {
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}
