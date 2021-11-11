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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //셀에 추가하고
        addSubview(wordLB)
        

        //해당 라벨의 크기 및 배경을 설정
        wordLB.translatesAutoresizingMaskIntoConstraints = false
        wordLB.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        wordLB.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        wordLB.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wordLB.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        wordLB.heightAnchor.constraint(equalToConstant: 100).isActive = true

        wordLB.backgroundColor = .white

        
      
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

