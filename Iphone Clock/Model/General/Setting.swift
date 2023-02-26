//
//  Setting.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 05.02.2023.
//

import Foundation


enum SettingsOptions {
    case label
    case textField
    case uiSwitch
}

struct Setting {
    let title: String
    let property: SettingsOptions
    let propertyValue: String
    let accesorry: Bool
}
