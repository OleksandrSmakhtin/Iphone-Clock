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
    
    
    
    
    
    
    
    
    
    
    
    
}


