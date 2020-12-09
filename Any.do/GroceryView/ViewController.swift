//
//  ViewController.swift
//  Any.do
//
//  Created by Yael Bilu Eran on 09/12/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    struct consts {
        static let padding: CGFloat = 8
        static let lineSpacing: CGFloat = 8
        static let minimumInteritemSpacing: CGFloat = 4
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let vModel = ViemModel()
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        let cellWidthHeight = width/2 - (consts.padding * 2)
        layout.itemSize = CGSize(width: cellWidthHeight, height: cellWidthHeight)
        layout.minimumLineSpacing = consts.lineSpacing
        layout.minimumInteritemSpacing = consts.minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: consts.padding, bottom: 0, right: consts.padding)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(GroceryCellView.nib, forCellWithReuseIdentifier: GroceryCellView.identifier)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        
        vModel.onNewData = { [weak self] index in
            self?.onNewData(at: index)
        }
        vModel.startService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vModel.startService()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vModel.end()
    }
    
//    deinit {
//        vModel.end()
//    }
    
    func onNewData(at index: Int){
        self.collectionView?.performBatchUpdates({
            let indexPath = IndexPath(row: index, section: 0)
            self.collectionView?.insertItems(at: [indexPath])
        }, completion: {[weak self] done in
            if index % 2 == 0 {
                self?.collectionView?.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vModel.dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroceryCellView.identifier, for: indexPath) as? GroceryCellView {
            let grocery  = vModel.dataAt(index: indexPath.row)
            cell.setup(grocery: grocery)
            return cell
        }
        return UICollectionViewCell()
    }
   

}

