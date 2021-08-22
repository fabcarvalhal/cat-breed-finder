//
//  ImageRecognizerError.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import Foundation

enum ImageRecognizerManagerError: Error {
    
    case unableToRecognizeImage
    case failedToInitializeModel
}
