//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit


class topMenuCV : UIView,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    // 셀의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ViewModel.VM.MenuList.count
        
    }
    // 셀에 텍스트 넣기
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topMenu", for: indexPath) as! topMenuCell
        
        cell.tmenutext.text = ViewModel.VM.MenuList[indexPath.item]
        return cell
        
    }
    // 셀 간 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath.row)
    }
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
       
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        return collectionView
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
       
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.widthAnchor.constraint(equalToConstant: CGFloat(ViewModel.VM.MenuList.count)*60).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 60).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        collectionView.register(topMenuCell.self, forCellWithReuseIdentifier: "topMenu")
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


