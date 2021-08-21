//
//  DataBaseManager.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import Foundation
import RealmSwift

protocol RealmManagerInterface: AnyObject {
    
    func save<T: Object>(_ object: T) throws
    func list<T: Object>(objectType: T.Type) throws -> Results<T>
    func delete<T: Object>(objectWith id: String, of type: T.Type) throws
}

final class RealmManager: RealmManagerInterface {
    
    private var realmInstance: Realm!
    
    func initializeRealm() throws {
        self.realmInstance = try Realm()
    }
    
    func list<T: Object>(objectType: T.Type) throws -> Results<T> {
        if realmInstance == nil { try initializeRealm() }
        return realmInstance.objects(objectType.self)
    }
    
    func save<T>(_ object: T) throws {
        if realmInstance == nil { try initializeRealm() }
        try realmInstance.write { object }
    }
    
    func delete<T: Object>(objectWith id: String, of type: T.Type) throws {
        guard let object: T = try list(objectType: T.self).filter(" id = %@", id).first else {
            throw RealmManagerError.notFoundWhileDeleting
        }
        
        try realmInstance.write {
            realmInstance.delete(object)
        }
    }
}

enum RealmManagerError: Error {
    
    case notFoundWhileDeleting
}
