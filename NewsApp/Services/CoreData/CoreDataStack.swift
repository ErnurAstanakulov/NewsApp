//
//  CoreDataStack.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation
import CoreData
enum DataEntity {
    case topHeadlines
    case everything
}

class CoreDataStackService: CoreDataServiceProtocol {
    
    private let moduleName = "NewsApp"
    
    let persistentContainer: NSPersistentContainer!
    
    init() {
        let container = NSPersistentContainer(name: moduleName, managedObjectModel: managedObjectModel)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
    }
    
    func getNews(for entity: DataEntity) -> NewsObject? {
        let context = persistentContainer.newBackgroundContext()
        do {
            switch entity {
            case .everything:
                let fetchRequest = NSFetchRequest<Everything>(entityName: "Everything")
                let request = try context.fetch(fetchRequest)
                return request.last?.news
            case .topHeadlines:
                let fetchRequest = NSFetchRequest<TopHeadlines>(entityName: "TopHeadlines")
                let request = try context.fetch(fetchRequest)
                return request.last?.news
            }
        } catch let fetchErr {
            print("Failed to fetch companies:", fetchErr)
        }
        return nil
    }
    
    func save(_ news: NewsObject, to entity: DataEntity) {
        persistentContainer.performBackgroundTask { (backgroundContext) in
            switch entity {
            case .everything:
                let entity = Everything(context: backgroundContext)
                entity.news = news
            case .topHeadlines:
                let entity = TopHeadlines(context: backgroundContext)
                entity.news = news
            }
            do {
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
            } catch let error {
                print("context doesnt save \(error)")
            }
        }
    }
    
    let managedObjectModel: NSManagedObjectModel = {
        let everythingEntity = setupEntity(className: String(describing: Everything.self))
        let topHeadlines = setupEntity(className: String(describing: TopHeadlines.self))
        let model = NSManagedObjectModel()
        model.entities = [everythingEntity, topHeadlines]
        return model
    }()
    
    class func setupEntity(className: String) -> NSEntityDescription {
        let entityDescription = NSEntityDescription()
        entityDescription.name = className
        entityDescription.managedObjectClassName = entityDescription.name
        
        let attribute = NSAttributeDescription()
        attribute.name = "news"
        attribute.attributeType = .transformableAttributeType
        attribute.isOptional = true
        
        entityDescription.properties = [attribute]
        return entityDescription
    }
}
