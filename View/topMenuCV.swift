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
        ViewModel.VM.MenuList.count     }
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
   
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ViewModel.VM.CurrentCell = indexPath.row
        print("CurrentCell = \(ViewModel.VM.CurrentCell)")
    }
    
    
    let TopMenucollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
       
        let TopMenucollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       
        
        
        return TopMenucollectionView
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(TopMenucollectionView)
       
        TopMenucollectionView.translatesAutoresizingMaskIntoConstraints = false
        TopMenucollectionView.delegate = self
        TopMenucollectionView.dataSource = self
        TopMenucollectionView.backgroundColor = .clear
        TopMenucollectionView.widthAnchor.constraint(equalToConstant: CGFloat(ViewModel.VM.MenuList.count)*60).isActive = true
        TopMenucollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
       
        
        TopMenucollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        TopMenucollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        TopMenucollectionView.isScrollEnabled = true
        
        TopMenucollectionView.register(topMenuCell.self, forCellWithReuseIdentifier: "topMenu")
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


