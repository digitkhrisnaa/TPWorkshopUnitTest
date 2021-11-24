//
//  PracticeViewController.swift
//  TPWorkshopUnitTest
//
//  Created by digital.aurum on 19/11/21.
//

import UIKit

class PracticeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    init() {
        super.init(nibName: "PracticeViewController", bundle: nil)
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
    }
}

extension PracticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data: [HashDiffable] = []
        switch data[indexPath.row] {
        case let data as Product:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            
            return cell
        case let data as Inspiration:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspirationCollectionViewCell", for: indexPath) as! InspirationCollectionViewCell
            
            return cell
        case let data as Ticker:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TickerCollectionViewCell", for: indexPath) as! TickerCollectionViewCell
            
            return cell
        default:
            fatalError("can't read the data")
        }
    }
}

extension PracticeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data: [HashDiffable] = []
        switch data {
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
