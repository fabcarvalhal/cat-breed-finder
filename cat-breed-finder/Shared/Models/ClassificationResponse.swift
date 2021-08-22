//
//  ImageRecognizerResponse.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import Foundation

struct ClassificationResponse {
    
    let classification: String?
    let confidence: Float?
    let hasObservation: Bool
}
