//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine


class contentsCV : UIView {
    
    private var cancellable = Set<AnyCancellable>()
    
    
    
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
        contentscollectionView.backgroundColor = .clear
        
        contentscollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        contentscollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentscollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentscollectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentscollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentscollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        contentscollectionView.isPagingEnabled = true
        
        
        contentscollectionView.register(contentsCell.self, forCellWithReuseIdentifier: "contents")
        contentscollectionView.register(ContentsCVMainView.self, forCellWithReuseIdentifier: "Main")
        contentscollectionView.register(ContentsCVDicView.self, forCellWithReuseIdentifier: "Dic")
        contentscollectionView.register(ContentsCVEmailView.self, forCellWithReuseIdentifier: "Email")
        contentscollectionView.register(ContentsCVNoteView.self, forCellWithReuseIdentifier: "Note")
        contentscollectionView.register(ContentsCVTimerView.self, forCellWithReuseIdentifier: "Timer")
        autoScroll()
        
       
    }
    
    func autoScroll(){
        ViewModel.VM.$CurrentCell.sink { value in
            let currenCellidx = IndexPath(item: value, section: 0)
            self.contentscollectionView.scrollToItem(at: currenCellidx, at: .centeredHorizontally, animated: true)
            
        }.store(in: &cancellable)
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
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main", for: indexPath)
        
        if indexPath.row == 0 {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Main", for: indexPath)
            
        }
        if indexPath.row == 1 {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Dic", for: indexPath)
        }
        if indexPath.row == 2 {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Email", for: indexPath)
        }
        if indexPath.row == 3 {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Note", for: indexPath)
        }
        if indexPath.row == 4 {
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Timer", for: indexPath)
        }
        
                
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = self.layer.frame.width
        let height = self.layer.frame.height

        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
       
    }
    
}
//let index = IndexPath(item: ViewModel.VM.CurrentCell, section: 0)
//collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)



