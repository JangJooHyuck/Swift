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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
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
       
        SidecollectionView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        SidecollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        SidecollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        SidecollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        SidecollectionView.register(sideMenuCell.self, forCellWithReuseIdentifier: "sideMenu")
        
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



