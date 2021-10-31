//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit

class TimerCell:UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    
   

    let myTableView: UITableView = UITableView()
    let list = ViewModel.VM.MenuList
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(myTableView)
        
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        TVlayout()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    func TVlayout(){
        
        //tableView layout
        
        myTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        myTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}




