//
//  CatBreedListResponse.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

typealias CatBreedListResponse = [CatBreed]

struct CatBreed: Codable {
    
    let adaptability: Int
    let affectionLevel: Int
    let childFriendly: Int
    let description: String
    let dogFriendly: Int
    let energyLevel: Int
    let grooming: Int
    let healthIssues: Int
    let id: String
    let image: CatImage?
    let intelligence: Int
    let lifeSpan: String
    let name: String
    let origin: String
    let sheddingLevel: Int
    let socialNeeds: Int
    let strangerFriendly: Int
    let vocalisation: Int
    let weight: CatWeight

    enum CodingKeys: String, CodingKey {
        
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case description = "description"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case id
        case image
        case intelligence
        case lifeSpan = "life_span"
        case name
        case origin
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation
        case weight
    }
    
    init(from realmObject: RealmCatBreed) {
        adaptability = realmObject.adaptability
        affectionLevel = realmObject.affectionLevel
        name = realmObject.name
        origin = realmObject.origin
        childFriendly = realmObject.childFriendly
        description = realmObject.breedDescription
        energyLevel = realmObject.energyLevel
        dogFriendly = realmObject.dogFriendly
        grooming = realmObject.grooming
        healthIssues = realmObject.healthIssues
        id = realmObject.id
        image = CatImage(url: realmObject.image?.url)
        weight = CatWeight(imperial: realmObject.weight?.imperial ?? "",
                           metric: realmObject.weight?.metric ?? "")
        intelligence = realmObject.intelligence
        lifeSpan = realmObject.lifeSpan
        sheddingLevel = realmObject.sheddingLevel
        socialNeeds = realmObject.socialNeeds
        strangerFriendly = realmObject.strangerFriendly
        vocalisation = realmObject.vocalisation
    }
}

// MARK: - Image
struct CatImage: Codable {
    
    let url: String?
}


// MARK: - Weight
struct CatWeight: Codable {
    
    let imperial: String
    let metric: String
}
