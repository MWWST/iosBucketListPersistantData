//
//  Mission.swift
//  bucketList
//
//  Created by Michael Weitzman on 1/13/16.
//  Copyright © 2016 World Source Tech. All rights reserved.
//

import Foundation

class Mission: NSObject, NSCoding {
    static var key: String = "Missions"
    static var schema: String = "theBucket"
    var mission: String
    var createdAt: NSDate
    
    init(obj: String) {
        mission = obj
        createdAt = NSDate()
    }
    
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(mission, forKey: "mission")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
    }
    
    //used for decoding (loading) objects
    required init?(coder aDecoder: NSCoder) {
        mission = aDecoder.decodeObjectForKey("mission") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    
    // MARK: - Queries
    static func all() -> [Mission] {
        var missions = [Mission]()
        let path = Database.dataFilePath("theBucket")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                missions = unarchiver.decodeObjectForKey(Mission.key) as! [Mission]
                unarchiver.finishDecoding()
            }
        }
        return missions
    }
    
    func save() {
        var missionsFromStorage = Mission.all()
        var exists = false
        for var i = 0; i < missionsFromStorage.count; ++i {
            if missionsFromStorage[i].createdAt == self.createdAt {
                missionsFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            missionsFromStorage.append(self)
        }
        Database.save(missionsFromStorage, toSchema: Mission.schema, forKey: Mission.key)
    }
    
    func delete() {
        var missionsFromStorage = Mission.all()
        var exists = false
        for var i = 0; i < missionsFromStorage.count; ++i {
            if missionsFromStorage[i].mission == self.mission {
                //                tasksFromStorage[i] = self
                
                missionsFromStorage.removeAtIndex(i)
                exists = true
            }
        }
        
        Database.save(missionsFromStorage, toSchema: Mission.schema, forKey: Mission.key)
    }


    
    
}