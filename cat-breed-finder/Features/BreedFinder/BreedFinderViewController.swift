//
//  CatFinderViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

final class CatFinderViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var breedNameLabel: UILabel!
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            catImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func createImagePickerAlert() -> UIAlertController {
        let alert = UIAlertController(title: "",
                                      message: "From wich source do you want to select the image?",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Library",
                                      style: .default,
                                      handler: { [weak self] _ in
                                        self?.pickImage(from: .photoLibrary)
                                      }))
        
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            alert.addAction(UIAlertAction(title: "Camera",
                                          style: .default,
                                          handler: { [weak self] _ in
                                            self?.pickImage(from: .camera)
                                          }))
        }
        
        alert.addAction(UIAlertAction(title: "Camera Roll",
                                      style: .default,
                                      handler: { [weak self] _ in
                                        self?.pickImage(from: .savedPhotosAlbum)
                                      }))
        return alert
    }
    
    private func pickImage(from source: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = source
        present(imagePickerController, animated: true)
    }
    
    @IBAction func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func selectImageAction() {
        present(createImagePickerAlert(), animated: true, completion: nil)
    }
}

