//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit

class topMenuCell:UICollectionViewCell{

    let tmenutext: UILabel = {
        let tmenutext = UILabel()
        tmenutext.textAlignment = .center
       
        return tmenutext
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tmenutext)
        tmenutext.textAlignment = .center
        tmenutext.translatesAutoresizingMaskIntoConstraints = false
      
        tmenutext.widthAnchor.constraint(equalToConstant: 50).isActive = true
        tmenutext.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tmenutext.layer.cornerRadius = 20
        tmenutext.layer.borderWidth = 1
        
        tmenutext.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
