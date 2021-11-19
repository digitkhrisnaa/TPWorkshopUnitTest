//
//  ThirdAdvancedViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 18/11/21.
//

import UIKit

class AdvancedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: AdvancedViewModel
    
    init() {
        viewModel = AdvancedViewModel(useCase: AdvancedUseCase())
        super.init(nibName: "AdvancedViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Advanced Unit Test"
        
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        bindViewModel()
        viewModel.didLoad()
    }
    
    func bindViewModel() {
        viewModel.receiveData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.onErrorReceiveData = { message in
            print(message)
        }
        
        viewModel.doSideEffect = { message in
            print(message)
        }
    }
}

extension AdvancedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        cell.configure(product: viewModel.products[indexPath.row])
        return cell
    }
}

extension AdvancedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 4, height: 300)
    }
}

extension AdvancedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.row)
    }
}
