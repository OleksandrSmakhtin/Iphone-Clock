//
//  DataPersistenceManager.swift
//  Iphone Clock
//
//  Created by Oleksandr Smakhtin on 14.02.2023.
//

import Foundation
import UIKit
import CoreData


class DataPersistenceManager {
    //MARK: - Singleton
    static let shared = DataPersistenceManager()
    
    //MARK: - Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: - Add World Time
    func addWorldTime(with model: WorldTime) {
        
        let time = WorldTimeCoreData(context: context)
        
        time.time = model.time
        time.city = model.city
        time.difference = model.difference
        time.region = model.region
        
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    //MARK: - Fetch World Time
    func fetchWorldTimes(completion: @escaping (Result<[WorldTimeCoreData], Error>) -> Void) {
        
        let request = WorldTimeCoreData.fetchRequest()
        
        do {
            let times = try context.fetch(request)
            completion(.success(times))
            
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
    
    //MARK: - Delete World Time
    func deleteWorldTime(with model: WorldTimeCoreData, completion: @escaping (Result<Void, Error>) -> Void) {
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    
    
    
    
    //MARK: - Add Alarm
    func addAlarm(with model: Alarm) {
        
        let alarm = AlarmCoreData(context: context)
        
        alarm.hours = model.hours
        alarm.minutes = model.minutes
        alarm.isOn = model.isOn
        
        do {
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    //MARK: - Fetch Alarms
    func fetchAlarms(completion: @escaping (Result<[AlarmCoreData], Error>) -> Void) {
        
        let request = AlarmCoreData.fetchRequest()
        
        do {
            let alarms = try context.fetch(request)
            completion(.success(alarms))
            
        } catch {
            completion(.failure(error))
        }
    }
    
    
    
    
    //MARK: - Delete Alarm
    func deleteAlarm(with model: AlarmCoreData, completion: @escaping (Result<Void, Error>) -> Void) {
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    
    
    
    
    
}


