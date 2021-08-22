//
//  ImageRecognizer.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import Foundation
import CoreML
import Vision
import UIKit.UIImage

protocol ImageRecognizerManagerInterface: AnyObject {
    
    func recognizeImage(_ image: UIImage, completion: @escaping ImageRecognizerManagerResponse)
}

typealias ImageRecognizerManagerResponse = (Swift.Result<ClassificationResponse, ImageRecognizerManagerError>) -> Void

final class ImageRecognizerManager: ImageRecognizerManagerInterface {
    
    private var model: VNCoreMLModel!
    private var request: VNRequest!
    
    private func initializeMLModel() throws {
        guard model == nil else { return }
        let configuration = MLModelConfiguration()
        try model = VNCoreMLModel(for: CatBreedClassification(configuration: configuration).model)
    }
    
    func recognizeImage(_ image: UIImage, completion: @escaping ImageRecognizerManagerResponse) {
        do {
            try initializeMLModel()
        } catch {
            completion(.failure(.failedToInitializeModel))
        }
        
        let orientation = UInt32(image.imageOrientation.rawValue)
        let cgOrientation = CGImagePropertyOrientation(rawValue: orientation) ?? .up
        
        guard let ciImage = CIImage(image: image) else {
            return completion(.failure(.unableToRecognizeImage))
        }
        
        // Create the request if necessary
        if request == nil {
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                request.preferBackgroundProcessing = true
                self?.proccessClassifications(for: request, error: error, completion: completion)
            }
            request.imageCropAndScaleOption = .centerCrop
            self.request = request
        }
        performRequest(for: ciImage, orientation: cgOrientation, completion: completion)
    }
    
    private func performRequest(for ciImage: CIImage,
                           orientation: CGImagePropertyOrientation,
                           completion: @escaping ImageRecognizerManagerResponse) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let requestHandler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
                try requestHandler.perform([self.request])
            } catch {
                completion(.failure(.unableToRecognizeImage))
            }
        }
    }
    
    private func proccessClassifications(for request: VNRequest, error: Error?, completion: @escaping ImageRecognizerManagerResponse) {
        guard let results = request.results else {
            return completion(.failure(.unableToRecognizeImage))
        }
        let observations = results as? [VNClassificationObservation] ?? [VNClassificationObservation]()
        if observations.isEmpty {
            let response = ClassificationResponse(classification: nil, confidence: nil, hasObservation: false)
            completion(.success(response))
            return
        }
        let topClassification = observations.prefix(1)
        let confidence = topClassification.first?.confidence ?? .zero
        let response = ClassificationResponse(classification: topClassification.first?.identifier,
                                              confidence: confidence * 100,
                                              hasObservation: true)
        completion(.success(response))
    }
}
