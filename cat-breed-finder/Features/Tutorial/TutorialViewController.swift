//
//  TutorialViewController.swift
//  cat-breed-finder
//
//  Created by Fabrício Silva Carvalhal on 21/08/21.
//

import UIKit


protocol TutorialViewControllerInterface: AnyObject {
    
    func stepTo(index: Int)
    func configureViewElements()
    func finish()
}

final class TutorialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    
    private lazy var presenter: TutorialPresenterInterface = {
        let presenter = TutorialPresenter()
        presenter.view = self
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "TutorialCell", bundle: .main),
                                forCellWithReuseIdentifier: TutorialCell.identifier)
        configureViewElements()
    }
    
    @IBAction func rightButtonAction() {
        presenter.rightButtonAction()
    }
    
    @IBAction func leftButtonAction() {
        presenter.leftButtonAction()
    }
}

extension TutorialViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension TutorialViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.stepsViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.identifier, for: indexPath)
        guard let tutorialCell = cell as? TutorialCell else { return cell }
        tutorialCell.set(viewModel: presenter.stepsViewModels[indexPath.row])
        return tutorialCell
    }
}

extension TutorialViewController: TutorialViewControllerInterface {
    
    func stepTo(index: Int) {
        let rect = collectionView.layoutAttributesForItem(at: IndexPath(row: index,
                                                                        section: 0))?.frame
        collectionView.scrollRectToVisible(rect!, animated: true)
        pageControl.currentPage = index
    }
    
    func configureViewElements() {
        leftButton.tintColor = presenter.isLeftButtonVisible ? UIColor.systemBlue : .clear
        leftButton.isEnabled = presenter.isLeftButtonVisible
        rightButton.title = presenter.righButtonTitle
        pageControl.numberOfPages = presenter.stepsViewModels.count
    }
    
    func finish() {
        if let mainTab = storyboard?.instantiateInitialViewController() {
            let window = UIApplication.shared.windows.first
            window?.rootViewController = mainTab
            window?.makeKeyAndVisible()
        }
    }
}
