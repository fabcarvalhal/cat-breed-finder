//
//  CatBreedListResponse.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import Foundation

struct CatBreedListResponse: Codable {
    
    let items: [CatBreed]
}

struct CatBreed: Codable {
    
    let adaptability: Int
    let affectionLevel: Int
    let altNames: String
    let cfaURL: String
    let childFriendly: Int
    let countryCode: String
    let countryCodes: String
    let description: String
    let dogFriendly, energyLevel, experimental, grooming: Int
    let hairless, healthIssues, hypoallergenic: Int
    let id: String
    let image: CatImage
    let indoor, intelligence, lap: Int
    let lifeSpan, name: String
    let natural: Int
    let origin: String
    let rare: Int
    let referenceImageID: String
    let rex, sheddingLevel, shortLegs, socialNeeds: Int
    let strangerFriendly, suppressedTail: Int
    let temperament: String
    let vcahospitalsURL: String
    let vetstreetURL: String
    let vocalisation: Int
    let weight: CatWeight
    let wikipediaURL: String

    enum CodingKeys: String, CodingKey {
        
        case adaptability
        case affectionLevel = "affection_level"
        case altNames = "alt_names"
        case cfaURL = "cfa_url"
        case childFriendly = "child_friendly"
        case countryCode = "country_code"
        case countryCodes = "country_codes"
        case description = "description"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case experimental, grooming, hairless
        case healthIssues = "health_issues"
        case hypoallergenic, id, image, indoor, intelligence, lap
        case lifeSpan = "life_span"
        case name, natural, origin, rare
        case referenceImageID = "reference_image_id"
        case rex
        case sheddingLevel = "shedding_level"
        case shortLegs = "short_legs"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case suppressedTail = "suppressed_tail"
        case temperament
        case vcahospitalsURL = "vcahospitals_url"
        case vetstreetURL = "vetstreet_url"
        case vocalisation, weight
        case wikipediaURL = "wikipedia_url"
    }
}

// MARK: - Image
struct CatImage: Codable {
    
    let height: Int
    let id: String
    let url: String
    let width: Int
}


// MARK: - Weight
struct CatWeight: Codable {
    
    let imperial: String
    let metric: String
}
