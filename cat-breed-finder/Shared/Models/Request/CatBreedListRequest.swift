//
//  CatBreedListRequest.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

struct CatBreedListRequest: DictionaryConvertible {
    
    let page: Int
    let limit: Int
}
