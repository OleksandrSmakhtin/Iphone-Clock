//
//  SettingsData.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 05.02.2023.
//

import Foundation


class SettingsData {
    static let shared = SettingsData()
    
    private let alarmSetting = [
        Setting(title: "Повтор", property: SettingsOptions.label, propertyValue: "Ніколи", accesorry: true),
        Setting(title: "Назва", property: SettingsOptions.textField, propertyValue: "Будильник", accesorry: false),
        Setting(title: "Мелодія", property: SettingsOptions.label, propertyValue: "Alarm", accesorry: true),
        Setting(title: "Повтор сигналу", property: SettingsOptions.uiSwitch, propertyValue: "on", accesorry: false)
    ]
    
    private let timerSettings = [
        Setting(title: "По закінченню", property: SettingsOptions.label, propertyValue: "Радар", accesorry: true)
    ]
    
    func getAlarmSettings() -> [Setting] {
        return alarmSetting
    }
    
    func getTimerSettings() -> [Setting] {
        return timerSettings
    }
}
