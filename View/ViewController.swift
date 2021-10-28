//
//  ViewController.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/09/29.
//

import UIKit

class ViewController: UIViewController {

    var HMenu : UIButton = {
        let HMenu : UIButton = UIButton()
        return HMenu
    }()
    
    lazy var topMenu: topMenuCV = {
        let topMenu: topMenuCV = topMenuCV(frame: .zero)
        return topMenu
    }()
    
    lazy var sideMenu: sideMenuCV = {
        let sideMenu: sideMenuCV = sideMenuCV(frame: .zero)
        return sideMenu
    }()
    
    lazy var contentsMenu: contentsCV = {
        let contentsMenu: contentsCV = contentsCV(frame: .zero)
        return contentsMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(HMenu)
        view.addSubview(topMenu)
        view.addSubview(sideMenu)
        view.addSubview(contentsMenu)
        
        Layout()
        
    }
    
    func Layout() {
        
        //탑 메뉴레이아웃
        topMenu.translatesAutoresizingMaskIntoConstraints = false
        topMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30).isActive = true
        topMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        topMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        topMenu.heightAnchor.constraint(equalToConstant: CGFloat((ViewModel.VM.MenuList.count) * 10)).isActive = true
        
        //사이드 메뉴레이아웃
        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        
        sideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: -50).isActive = true
        sideMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        sideMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: -70).isActive = true

        sideMenu.heightAnchor.constraint(equalToConstant: CGFloat((ViewModel.VM.MenuList.count) * 100)).isActive = true
        
        //콘텐츠 레이아웃
        contentsMenu.translatesAutoresizingMaskIntoConstraints = false
        
        contentsMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: -50).isActive = true
        contentsMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        contentsMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: -70).isActive = true

        contentsMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //햄버거메뉴버튼 레이아웃
        HMenu.translatesAutoresizingMaskIntoConstraints = false
        HMenu.widthAnchor.constraint(equalToConstant: 50).isActive = true
        HMenu.heightAnchor.constraint(equalToConstant: 50).isActive = true
        HMenu.leadingAnchor.constraint(equalTo: topMenu.leadingAnchor, constant: -10).isActive = true
        HMenu.topAnchor.constraint(equalTo: topMenu.topAnchor, constant: 0).isActive = true
        HMenu.backgroundColor = .black
    }
}
