//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit

class TimerCell:UICollectionViewCell{

    let contents: UILabel = {
        let contents = UILabel()
        contents.textAlignment = .center
        return contents
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contents)
        
        contents.backgroundColor = .brown
        contents.text = "Timer"
        contents.textAlignment = .center
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.backgroundColor = .magenta
        contents.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contents.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        contents.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contents.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contents.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}




