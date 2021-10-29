//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit


class contentsCV : UIView {
    
    
    let contentscollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        
       
        let contentscollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentscollectionView.backgroundColor = .white

        return contentscollectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentscollectionView)
        
        contentscollectionView.isScrollEnabled = true
        contentscollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentscollectionView.delegate = self
        contentscollectionView.dataSource = self
        contentscollectionView.backgroundColor = .red
        
        contentscollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentscollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentscollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentscollectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentscollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentscollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        contentscollectionView.isPagingEnabled = true
        
        
        contentscollectionView.register(contentsCell.self, forCellWithReuseIdentifier: "contents")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension contentsCV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ViewModel.VM.MenuList.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contents", for: indexPath) as! contentsCell
        cell.contents.text = ViewModel.VM.MenuList[indexPath.row]
                
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = self.layer.frame.width
        let height = self.layer.frame.height

        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(ViewModel.VM.CurrentCell)
        
        collectionView.scrollToItem(at: IndexPath(index: 2), at: .centeredHorizontally, animated: true)
    
    }
    
    
}




