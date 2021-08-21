//
//  PersistedCatBreed.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 20/08/21.
//

import RealmSwift

final class RealmCatBreed: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var adaptability: Int
    @Persisted var affectionLevel: Int
    @Persisted var childFriendly: Int
    @Persisted var breedDescription: String
    @Persisted var dogFriendly: Int
    @Persisted var energyLevel: Int
    @Persisted var grooming: Int
    @Persisted var healthIssues: Int
    @Persisted var image: RealmCatImage?
    @Persisted var intelligence: Int
    @Persisted var lifeSpan: String
    @Persisted var name: String
    @Persisted var origin: String
    @Persisted var sheddingLevel: Int
    @Persisted var socialNeeds: Int
    @Persisted var strangerFriendly: Int
    @Persisted var vocalisation: Int
    @Persisted var weight: RealmCatWeight?
    
    convenience init(from breed: CatBreed) {
        self.init()
        id = breed.id
        adaptability = breed.adaptability
        childFriendly = breed.childFriendly
        dogFriendly = breed.dogFriendly
        breedDescription = breed.description
        energyLevel = breed.energyLevel
        grooming = breed.grooming
        healthIssues = breed.healthIssues
        intelligence = breed.intelligence
        lifeSpan = breed.lifeSpan
        name = breed.name
        origin = breed.origin
        sheddingLevel = breed.sheddingLevel
        socialNeeds = breed.socialNeeds
        strangerFriendly = breed.strangerFriendly
        vocalisation = breed.vocalisation
        image = RealmCatImage(from: breed.image)
        weight = RealmCatWeight(from: breed.weight)
    }
}
