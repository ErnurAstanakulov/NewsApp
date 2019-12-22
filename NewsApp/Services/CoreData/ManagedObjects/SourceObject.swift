//
//  SourceObject.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation
import CoreData

@objc(SourceObject)
public class SourceObject: NSObject, NSCoding {
    var id: String?
    var name: String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
    }
    
    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeObject(forKey: "id") as? String
        let name = coder.decodeObject(forKey: "name") as? String
        self.init(id: id, name: name)
    }
}
