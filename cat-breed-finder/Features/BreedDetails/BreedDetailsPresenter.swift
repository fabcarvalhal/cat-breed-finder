//
//  BreedDetailsPresenter.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import Foundation

protocol BreedDetailsPresenterInterface: AnyObject {
    
    var breed: CatBreed? { get set }
}

final class BreedDetailsPresenter: BreedDetailsPresenterInterface {
    
    var breed: CatBreed?
    
}
