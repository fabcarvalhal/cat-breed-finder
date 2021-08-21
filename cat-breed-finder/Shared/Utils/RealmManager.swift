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
    func getObject<T: Object>(by id: String, of type: T.Type) throws -> T?
}

final class RealmManager: RealmManagerInterface {
    
    private var realmInstance: Realm!
    
    func initializeRealm() throws {
        self.realmInstance = try Realm(configuration: .defaultConfiguration)
    }
    
    func list<T: Object>(objectType: T.Type) throws -> Results<T> {
        if realmInstance == nil { try initializeRealm() }
        return realmInstance.objects(objectType)
    }
    
    func save<T: Object>(_ object: T) throws {
        if realmInstance == nil { try initializeRealm() }
        try realmInstance.write {
            realmInstance.add(object)
        }
    }
    
    func delete<T: Object>(objectWith id: String, of type: T.Type) throws {
        guard let object: T = try getObject(by: id, of: type) else {
            throw RealmManagerError.notFoundWhileDeleting
        }
        
        try realmInstance.write {
            realmInstance.delete(object)
        }
    }
    
    func getObject<T: Object>(by id: String, of type: T.Type) throws -> T? {
        if realmInstance == nil { try initializeRealm() }
        return realmInstance.object(ofType: type, forPrimaryKey: id)
    }
}

enum RealmManagerError: Error {
    
    case notFoundWhileDeleting
}


