//
//  RepeatData.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 26.02.2023.
//

import Foundation


class RepeatData {
    //MARK: - Singleton
    static let shared = RepeatData()
    
    func getRepeatData() -> [String] {
        
        let repeats = ["Кожен понеділок", "Кожен вівторок", "Кожну середу", "Кожен четвер", "Кожну пʼятницю", "Кожну суботу", "Кожну неділю"]
        
        return repeats
    }
}
