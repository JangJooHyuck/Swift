//
//  ContentCVTimerViewTableCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/11/09.
//

import Foundation
import UIKit

class ContentsCVNoteViewCell: UITableViewCell {
    
    let wordLB: UILabel = {
        let wordLB = UILabel()
        wordLB.textAlignment = .center
        return wordLB
    }()
    
    let wordContentsLB: UILabel = {
        let wordContentsLB = UILabel()
        wordContentsLB.textAlignment = .left
        return wordContentsLB
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //셀에 추가하고
        addSubview(wordLB)
        addSubview(wordContentsLB)
      
        

        //해당 라벨의 크기 및 배경을 설정
        wordLB.translatesAutoresizingMaskIntoConstraints = false
   
        wordLB.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        wordLB.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        wordLB.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wordLB.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
      

        wordLB.backgroundColor = .white
        
        //해당 라벨의 크기 및 배경을 설정
        wordContentsLB.translatesAutoresizingMaskIntoConstraints = false
        wordContentsLB.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        wordContentsLB.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        wordContentsLB.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wordContentsLB.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        wordContentsLB.numberOfLines = 10
        
        
        
        wordContentsLB.textAlignment = .center
        wordContentsLB.layer.borderWidth = 1
        wordContentsLB.isHidden = true
        wordContentsLB.backgroundColor = .clear
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

