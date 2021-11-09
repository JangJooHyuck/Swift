//
//  ContentCVTimerViewTableCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/11/09.
//

import Foundation
import UIKit

class ContentCVTimerViewTableCell: UITableViewCell {
    
    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        //셀에 추가하고
        addSubview(lbl)

        //해당 라벨의 크기 및 배경을 설정
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        lbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        lbl.backgroundColor = .white

        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
