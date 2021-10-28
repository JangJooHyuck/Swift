//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit


class sideMenuCV : UIView,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ViewModel.VM.MenuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sideMenu", for: indexPath) as! sideMenuCell
        
        cell.sideMenutext.text = ViewModel.VM.MenuList[indexPath.item]
        return cell
        
    }
    let SidecollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
       
        let SidecollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        SidecollectionView.backgroundColor = .white

        return SidecollectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(SidecollectionView)
        SidecollectionView.translatesAutoresizingMaskIntoConstraints = false
        SidecollectionView.delegate = self
        SidecollectionView.dataSource = self
        
        SidecollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 60).isActive = true
        SidecollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        SidecollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 200).isActive = true
        SidecollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
        SidecollectionView.register(sideMenuCell.self, forCellWithReuseIdentifier: "sideMenu")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



