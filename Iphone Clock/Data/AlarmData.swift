//
//  AlarmData.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 02.02.2023.
//

import Foundation


class AlarmData {
    
    static let shared = AlarmData()
    
    private let alarmArray = [
        Alarm(hours: "06", minutes: "00", isOn: false),
        Alarm(hours: "06", minutes: "30", isOn: false),
        Alarm(hours: "07", minutes: "10", isOn: false),
        Alarm(hours: "07", minutes: "45", isOn: false),
        Alarm(hours: "08", minutes: "15", isOn: false),
        Alarm(hours: "09", minutes: "10", isOn: false),
    ]
    
    func alarms() -> [Alarm] {
        return alarmArray
    }
    
}
