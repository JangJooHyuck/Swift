//
//  ViewController.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/09/29.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var cancellable = Set<AnyCancellable>()
  
    var blurView = UIView()
    
    var indicator = UIView()
    
    
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
        view.addSubview(indicator)
        view.addSubview(blurView)
       
        Layout()
        indicatorMove()
        closeSide()
    }
    
    func Layout() {
        //blurview 레이아웃
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        blurView.isUserInteractionEnabled = false
       
        blurView.topAnchor.constraint(equalTo: topMenu.topAnchor, constant: 0).isActive = true
        blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.5).isActive = true
        blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.5).isActive = true
        blurView.layer.zPosition = -1
        blurView.layer.cornerRadius = 5
        blurView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        blurView.isHidden = true
        
        //indicator 레이아웃
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        indicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 10).isActive = true
        indicator.topAnchor.constraint(equalTo: topMenu.bottomAnchor, constant: -10).isActive = true
        indicator.transform = CGAffineTransform(translationX: 0, y: 0)
        
        indicator.layer.cornerRadius = 5
        indicator.layer.zPosition = -1
        indicator.backgroundColor = .red
        
        //탑 메뉴레이아웃
        topMenu.translatesAutoresizingMaskIntoConstraints = false
        
        topMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 60).isActive = true
      
        topMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        topMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topMenu.layer.zPosition = -2
        topMenu.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        //햄버거메뉴 버튼 레이아웃
        HamBT.translatesAutoresizingMaskIntoConstraints = false
        
        HamBT.backgroundColor = .black
        HamBT.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        HamBT.widthAnchor.constraint(equalToConstant: 50).isActive = true
        HamBT.heightAnchor.constraint(equalToConstant: 50).isActive = true
        HamBT.topAnchor.constraint(equalTo: topMenu.topAnchor, constant: 0).isActive = true
        HamBT.layer.zPosition = 999
        HamBT.addTarget(self, action: #selector(HamBTpressed), for: .touchUpInside)
       
        //사이드 메뉴레이아웃
        sideMenu.translatesAutoresizingMaskIntoConstraints = false
        sideMenu.backgroundColor = .clear
        sideMenu.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -320).isActive = true
        sideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10).isActive = true
        sideMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        sideMenu.heightAnchor.constraint(equalToConstant: CGFloat((ViewModel.VM.MenuList.count) * 100)).isActive = true
        sideMenu.bringSubviewToFront(blurView)
        sideMenu.isHidden = true
        
        //콘텐츠 레이아웃
        contents.translatesAutoresizingMaskIntoConstraints = false
        contents.layer.zPosition = -1
        contents.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        contents.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contents.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        contents.topAnchor.constraint(equalTo: topMenu.bottomAnchor).isActive = true
        
        
        
        
    }
    //햄버거메뉴버튼 터치이벤트
    @objc func HamBTpressed() {
        if buttonTap == false {
       
            SideMenuOpen()
            
        }
        else{
           
            SideMenuClose()
            
        }
    }
    // 사이드메뉴 오픈
    func SideMenuOpen(){
        print("sideMenuOpen")
        HamBT.backgroundColor = .red
        sideMenu.isHidden = false
        buttonTap = true
        blurView.isHidden = false
        //콘텐츠 및 탑 메뉴 클릭 제한
      
        topMenu.isUserInteractionEnabled = false
        contents.isUserInteractionEnabled = false
    }
    // 사이드메뉴 클로즈
    func SideMenuClose(){
        HamBT.backgroundColor = .black
        print("sideMenuClose")
        sideMenu.isHidden = true
        buttonTap = false
        blurView.isHidden = true
        //콘텐츠 및 탑 메뉴 클릭 제한 해제
        topMenu.isUserInteractionEnabled = true
        contents.isUserInteractionEnabled = true
        topMenu.backgroundColor = .clear
        contents.backgroundColor = .clear
    }
    
    func indicatorMove(){
        ViewModel.VM.$CurrentCell.sink { value in
            UIView.animate(withDuration: 1.0,
                animations: {
                    
                    if value == 0 {
                        self.indicator.transform = CGAffineTransform(translationX: CGFloat(((value + 1)) * 70), y: 0)
                    }
                    else {
                        self.indicator.transform = CGAffineTransform(translationX: CGFloat(((value + 1)) * 64), y: 0)
                    }
                    
                },
                completion: nil
              )

        }.store(in: &cancellable)
    }
    
    func closeSide() {
        ViewModel.VM.$CurrentCell.sink { value in
            self.SideMenuClose()
    }.store(in: &cancellable)
    
    }
    
}

//UIView.animate(withDuration: 1.0, delay: 0.0,
//    options: .curveEaseOut,
//    animations: {
//        self.indicator.center.x += 60
//    },
//    completion: nil
//  )
