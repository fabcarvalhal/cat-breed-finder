//
//  BreedFinderPresenter.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import Foundation
import UIKit.UIImage


protocol BreedFinderPresenterInterface: AnyObject {
    
    func classify(image: UIImage)
}

final class BreedFinderPresenter: BreedFinderPresenterInterface {
    
    weak var view: BreedFinderViewControllerInterface?
    
    private let imageRecognizerManager: ImageRecognizerManagerInterface
    
    init(imageRecognizerManager: ImageRecognizerManagerInterface = ImageRecognizerManager()) {
        self.imageRecognizerManager = imageRecognizerManager
    }
    
    func classify(image: UIImage) {
        view?.showLoading(isLoading: true)
        imageRecognizerManager.recognizeImage(image) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view?.showLoading(isLoading: false)
                switch result {
                case .success(let response):
                    var responseString = ""
                    if response.hasObservation {
                        let confidence = String(format: "%.2f", response.confidence ?? .zero)
                        responseString = "Its a \(response.classification ?? "") with \(confidence)% confidence! :)" 
                    } else {
                        responseString = "Sorry, I couldnt classify the cat in this image"
                    }
                    self.view?.displayBreedResult(responseString)
                case .failure:
                    self.view?.displayBreedResult("There was an error while classifying the cat, sorry.")
                }
            }
        }
    }
}

