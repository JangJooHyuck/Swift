//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit


class sideMenuCell:UICollectionViewCell{

    let sideMenutext: UILabel = {
        let sideMenutext = UILabel()
        sideMenutext.textAlignment = .left
        return sideMenutext
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sideMenutext)
       
        sideMenutext.translatesAutoresizingMaskIntoConstraints = false
        sideMenutext.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sideMenutext.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sideMenutext.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        sideMenutext.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        sideMenutext.backgroundColor = .clear
      
    }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

