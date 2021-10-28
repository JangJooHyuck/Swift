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
        tmenutext.translatesAutoresizingMaskIntoConstraints = false
        tmenutext.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        tmenutext.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        tmenutext.backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
