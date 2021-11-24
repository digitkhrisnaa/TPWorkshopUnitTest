//
//  ForthViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit

class IntermediateViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: IntermediateViewModel
    
    init() {
        self.viewModel = IntermediateViewModel(useCase: IntermediateUseCase())
        super.init(nibName: "IntermediateViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Intermediate Unit Test"
        
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        collectionView.register(UINib(nibName: "InspirationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InspirationCollectionViewCell")
        collectionView.register(UINib(nibName: "TickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TickerCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        bindViewModel()
        viewModel.onDidLoad()
    }
    
    func bindViewModel() {
        viewModel.didReceiveData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.didGotError = { messages in
            print(messages.joined(separator: ","))
        }
        
        viewModel.hasTicker = { [weak self] hasTicker in
            if hasTicker {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self?.viewModel.onFireDate()
                }
            }
        }
    }
}

extension IntermediateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.data[indexPath.row] {
        case let data as Product:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            cell.configure(product: data)
            return cell
        case let data as Inspiration:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspirationCollectionViewCell", for: indexPath) as! InspirationCollectionViewCell
            cell.configure(inspiration: data)
            return cell
        case let data as Ticker:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TickerCollectionViewCell", for: indexPath) as! TickerCollectionViewCell
            cell.tickerLabel.text = data.title
            return cell
        default:
            fatalError("can't read the data")
        }
    }
}

extension IntermediateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.data[indexPath.row] {
        case is Product:
            return CGSize(width: (collectionView.frame.width / 2) - 4, height: 300)
        case is Inspiration:
            return CGSize(width: collectionView.frame.width - 4, height: 250)
        case is Ticker:
            return CGSize(width: collectionView.frame.width - 4, height: 50)
        default:
            fatalError("can't read the data")
        }
    }
}
