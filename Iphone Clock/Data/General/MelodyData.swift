//
//  MelodyData.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 27.02.2023.
//

import Foundation

class MelodyData {
    //MARK: - Singleton
    static let shared = MelodyData()
    
    func getMelodies() -> [Melody] {
        
        let melodies = [
           Melody(title: "Вібрація", accessibilityTitle: "По замовч.", isAccessible: true, isChosen: false),
           Melody(title: "Магазин звуків", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Завантажити всі звуки", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Вибір пісні", accessibilityTitle: nil, isAccessible: true, isChosen: false),
           Melody(title: "Радар (по замовчуванню)", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Алекс", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Вершина", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Вісник", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Хвилі", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Вступ", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Грози", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Зип", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Ілюмінація", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Космос", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Кристали", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Маяк", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "В гору", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Мерцання", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Обрив", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Відображення", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Перезвон", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Підʼйом", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Позивний", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Полуночник", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "У моря", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Сяйво", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Сентя", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Скоріше", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Сузірʼя", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Час", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Шовк", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Електросхема", accessibilityTitle: nil, isAccessible: false, isChosen: false),
           Melody(title: "Класичні", accessibilityTitle: nil, isAccessible: true, isChosen: false),
           Melody(title: "Немає", accessibilityTitle: nil, isAccessible: false, isChosen: false)
        ]
        
        return melodies
        
    }
    
    
}
