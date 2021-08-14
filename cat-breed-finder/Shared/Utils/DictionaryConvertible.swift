//
//  DictionaryConvertible.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

/// Conform a struct with this to convert it to [String: Any] using toDictionary() function
protocol DictionaryConvertible {
    
    func toDictionary() -> [String: Any]
}

extension DictionaryConvertible {
    
    func toDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        let keyValuePairs = mirror
            .children
            .lazy
            .map({ (key: String?, value: Any) -> (String, Any)? in
                guard let key = key else { return nil }
            return (key, value)
            })
            .compactMap { $0 }
        return Dictionary<String, Any>(uniqueKeysWithValues: keyValuePairs)
    }
}

