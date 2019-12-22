//
//  TopHeadlines.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation
import CoreData

@objc(TopHeadlines)
public final class TopHeadlines: NSManagedObject {

    // MARK: - Properties NSManaged
    @NSManaged public var news: NewsObject?

   @nonobjc public class func fetchRequest() -> NSFetchRequest<TopHeadlines> {
        return NSFetchRequest<TopHeadlines>(entityName: "TopHeadlines")
    }
}

