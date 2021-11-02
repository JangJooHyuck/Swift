//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine

class sideMenuCell:UICollectionViewCell{

    private var cancellable = Set<AnyCancellable>()
    
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
        
       
        sideMenutext.layer.borderWidth = 1
        
        sideMenutext.backgroundColor = .yellow
        highlightSideMenu()
    }
    func highlightSideMenu(){
        ViewModel.VM.$didSideMenuHighright.sink { value in
            print(value)
            if value == true {
                self.sideMenutext.backgroundColor = .red
            }
            else {
                self.sideMenutext.backgroundColor = .yellow
            }
        }.store(in: &cancellable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

