//
//  RealmCatImage.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import RealmSwift

final class RealmCatImage: Object {
    
    @Persisted var url: String?
    
    convenience init(from catImage: CatImage?) {
        self.init()
        url = catImage?.url
    }
}
