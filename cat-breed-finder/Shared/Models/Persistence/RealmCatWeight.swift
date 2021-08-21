//
//  RealmCatWeight.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import RealmSwift

final class RealmCatWeight: Object {
    
    @Persisted var imperial: String
    @Persisted var metric: String
    
    convenience init(from catWeight: CatWeight) {
        self.init()
        imperial = catWeight.imperial
        metric = catWeight.metric
    }
}
