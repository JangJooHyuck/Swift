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
        cell.sideMenutext.backgroundColor = .clear
        cell.sideMenutext.layer.borderWidth = 1
        cell.sideMenutext.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 0.5)
        if cell.sideMenutext.text == "메인" {
            cell.sideMenutext.text = ViewModel.VM.alignLeftAndRight(left: "🏠", right: "메인", length: 15)
        }
        if cell.sideMenutext.text == "사전" {
            cell.sideMenutext.text = ViewModel.VM.alignLeftAndRight(left: "📚", right: "사전", length: 15)
        }
        if cell.sideMenutext.text == "이메일" {
            cell.sideMenutext.text = ViewModel.VM.alignLeftAndRight(left: "📨", right: "이메일", length: 15)
        }
        if cell.sideMenutext.text == "단어장" {
            cell.sideMenutext.text = ViewModel.VM.alignLeftAndRight(left: "📋", right: "단어장", length: 15)
        }
        if cell.sideMenutext.text == "타이머" {
            cell.sideMenutext.text = ViewModel.VM.alignLeftAndRight(left: "⏰", right: "타이머", length: 15)
        }
        
        return cell
        
    }
    // 클릭 이벤트
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ViewModel.VM.CurrentCell = indexPath.row
        
        //사이드메뉴 이동을 위함.
        //기존에 위에 커렌트셀만 변경하면 탑메뉴 이동시에도 메뉴버튼이 움직였음.
        ViewModel.VM.SideCurrentCell = indexPath.row
        
        print("CurrentCell = \(ViewModel.VM.CurrentCell)")
    }
     func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
    }
    let SidecollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
       
        let SidecollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       

        return SidecollectionView
    }()
    
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        
        addSubview(SidecollectionView)
        
        SidecollectionView.translatesAutoresizingMaskIntoConstraints = false
        SidecollectionView.delegate = self
        SidecollectionView.dataSource = self
        SidecollectionView.backgroundColor = .white
       
        SidecollectionView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        SidecollectionView.heightAnchor.constraint(equalToConstant: CGFloat(ViewModel.VM.MenuList.count * 140)).isActive = true
        SidecollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        SidecollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
       
        SidecollectionView.register(sideMenuCell.self, forCellWithReuseIdentifier: "sideMenu")
        
        
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}



