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
        sideMenutext.textAlignment = .center
        return sideMenutext
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sideMenutext)
        sideMenutext.translatesAutoresizingMaskIntoConstraints = false
        
        sideMenutext.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        sideMenutext.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        sideMenutext.layer.cornerRadius = 20
        sideMenutext.layer.borderWidth = 1
        sideMenutext.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

