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
    
    func getRepeatData() -> [Repeat] {
        
        let repeats = [
            Repeat(title: "Кожен понеділок", shortcut: "Пн", isChosen: false),
            Repeat(title: "Кожен вівторок", shortcut: "Вт", isChosen: false),
            Repeat(title: "Кожну середу", shortcut: "Ср", isChosen: false),
            Repeat(title: "Кожен четвер", shortcut: "Чт", isChosen: false),
            Repeat(title: "Кожну пʼятницю", shortcut: "Пт", isChosen: false),
            Repeat(title: "Кожну суботу", shortcut: "Сб", isChosen: false),
            Repeat(title: "Кожну неділю", shortcut: "Нд", isChosen: false)
        ]
        
        return repeats
    }
}
