//
//  WorldTimeData.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 01.02.2023.
//

import Foundation


class WorldTimeData {
    
    static let shared = WorldTimeData()
    
    
    
    private let timesArray = [
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Лос-Анджелес", region: "США", time: "06:06"),
        WorldTime(difference: "Сьогодні, -2 Г", city: "Дублін", region: "Ірландія", time: "14:06"),
        WorldTime(difference: "Завтра, +9 Г", city: "Мельбурн", region: "Австралія", time: "01:06"),
        WorldTime(difference: "Сьогодні, -10 Г", city: "Сан-Франциско", region: "США", time: "06:06")
    ]
    
    func timeZone() -> [WorldTime] {
        return timesArray
    }
}
