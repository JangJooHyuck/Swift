//
//  ViewController.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/09/29.
//

import UIKit

class ViewController: UIViewController {

    
    var HamBT: UIButton = {
        let HamBT : UIButton = UIButton(frame: .zero)
        return HamBT
    }()
    var buttonTap = false
   
    // topMenu
    var topMenu: topMenuCV = {
        let topMenu: topMenuCV = topMenuCV(frame: .zero)
        return topMenu
    }()
    
    var sideMenu: sideMenuCV = {
        let sideMenu: sideMenuCV = sideMenuCV(frame: .zero)
        return sideMenu
    }()
    
    var contents: contentsCV = {
        let contents: contentsCV = contentsCV(frame: .zero)
        return contents
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(HamBT)
        view.addSubview(topMenu)
        view.addSubview(sideMenu)
        view.addSubview(contents)
        
        
        
        Layout()
        
    }
    
    func Layout() {
        
        //탑 메뉴레이아웃
        topMenu.translatesAutoresizingMaskIntoConstraints = false
        
        topMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        topMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topMenu.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        //햄버거메뉴 버튼 레이아웃
        HamBT.translatesAutoresizingMaskIntoConstraints = false
        
        HamBT.backgroundColor = .black
        HamBT.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        HamBT.widthAnchor.constraint(equalToConstant: 50).isActive = true
        HamBT.heightAnchor.constraint(equalToConstant: 50).isActive = true
        HamBT.topAnchor.constraint(equalTo: topMenu.topAnchor, constant: 0).isActive = true
        
        HamBT.addTarget(self, action: #selector(HamBTpressed), for: .touchUpInside)
       
        //사이드 메뉴레이아웃
        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        sideMenu.backgroundColor = .clear
        sideMenu.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -320).isActive = true
        sideMenu.heightAnchor.constraint(equalToConstant: 300).isActive = true
        sideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        
        sideMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true

        sideMenu.heightAnchor.constraint(equalToConstant: CGFloat((ViewModel.VM.MenuList.count) * 100)).isActive = true
        sideMenu.isHidden = true
        
        //콘텐츠 레이아웃
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.layer.zPosition = -1
        contents.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        contents.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contents.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        contents.topAnchor.constraint(equalTo: topMenu.bottomAnchor).isActive = true
        contents.alpha = 0.5
        contents.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
    }
    //햄버거메뉴버튼 터치이벤트
    @objc func HamBTpressed() {
        if buttonTap == false {
        HamBT.backgroundColor = .red
            SideMenuOpen()
        }
        else{
            HamBT.backgroundColor = .black
            SideMenuClose()
        }
    }
    // 사이드메뉴 오픈
    func SideMenuOpen(){
        print("sideMenuOpen")
        sideMenu.isHidden = false
        buttonTap = true
        //콘텐츠 및 탑 메뉴 클릭 제한
        topMenu.isUserInteractionEnabled = false
        contents.isUserInteractionEnabled = false
    }
    // 사이드메뉴 클로즈
    func SideMenuClose(){
        print("sideMenuClose")
        sideMenu.isHidden = true
        buttonTap = false
        //콘텐츠 및 탑 메뉴 클릭 제한 해제
        topMenu.isUserInteractionEnabled = true
        contents.isUserInteractionEnabled = true
    }
    
    
    
}
