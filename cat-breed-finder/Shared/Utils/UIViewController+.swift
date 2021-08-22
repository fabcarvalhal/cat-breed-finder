//
//  UIViewController+.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

extension UIViewController {
    
    func displayLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoading(completion: (() -> Void)? = nil) {
        guard presentedViewController is UIAlertController else { return }
        presentedViewController?.dismiss(animated: true, completion: completion)
    }
    
    func showErrorAlert(message: String, title: String, tryAgainHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let tryAgainHandler = tryAgainHandler {
            alert.addAction(UIAlertAction(title: "Try again", style: .default) { _ in
                tryAgainHandler()
            })
        }
        present(alert, animated: true, completion: nil)
    }
}
