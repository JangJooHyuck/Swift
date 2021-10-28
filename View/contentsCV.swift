//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit


class contentsCV : UIView,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ViewModel.VM.MenuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "content", for: indexPath)
        cell.backgroundColor = .black
        
        return cell
        
    }
    let contentsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
       
        let contentsView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        

        return contentsView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentsView)
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.delegate = self
        contentsView.dataSource = self
        
        contentsView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 60).isActive = true
        contentsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        contentsView.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        contentsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
        contentsView.register(sideMenuCell.self, forCellWithReuseIdentifier: "content")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}




