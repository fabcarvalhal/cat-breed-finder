//
//  CatFinderViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 14/08/21.
//

import UIKit

protocol BreedFinderViewControllerInterface: AnyObject {
    
    func showLoading(isLoading: Bool)
    func displayBreedResult(_ result: String)
}

final class BreedFinderViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var breedNameLabel: UILabel!
        
    private lazy var presenter: BreedFinderPresenterInterface = {
        let presenter = BreedFinderPresenter()
        presenter.view = self
        return presenter
    }()
    
    @IBAction func cancelAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func selectImageAction() {
        present(createImagePickerAlert(), animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        catImageView.layer.cornerRadius = catImageView.bounds.height / 2
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension BreedFinderViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) { [weak self] in
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self?.catImageView.image = image
                self?.presenter.classify(image: image)
            }
        }
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
}

extension BreedFinderViewController: BreedFinderViewControllerInterface {
    
    func showLoading(isLoading: Bool) {
        isLoading ? displayLoading() : hideLoading()
    }
    
    func displayBreedResult(_ result: String) {
        breedNameLabel.text = result
    }
}
