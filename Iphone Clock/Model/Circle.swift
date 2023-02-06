//
//  Circle.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 06.02.2023.
//

import Foundation


struct Circle {
    let circle: Int
    var time: String
    
    mutating func updateTime(with time: String) {
        self.time = time
    }
}
