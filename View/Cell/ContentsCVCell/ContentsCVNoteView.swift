//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import CoreData

class ContentsCVNoteView:UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    let NoteText = UILabel()
    let NoteTableView = UITableView()
    
    //셀이 비어있나요?
    let emptyText = UILabel()
    //선택된 셀의 행이 뭔지 판단함.
    var selectedIndex: Int = -1
    // 셀이 커졌는지 ?
    var isCellup :Bool = false
    
    var NoteArray = [NSManagedObject]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(emptyText)
       
        self.addSubview(NoteText)
        self.addSubview(NoteTableView)
        
        NoteTableView.translatesAutoresizingMaskIntoConstraints = false
        NoteText.translatesAutoresizingMaskIntoConstraints = false
        
        self.NoteTableView.dataSource = self
        self.NoteTableView.delegate = self
        
        self.NoteTableView.register(ContentsCVNoteViewCell.self, forCellReuseIdentifier: "cell")
        
        
        tableviewLayout()
        textLayout()
        
        
    }
  
    
    func textLayout() {
        NoteText.textAlignment = .center
        NoteText.font = UIFont.systemFont(ofSize: 50)
        NoteText.text = "단어장"
        NoteText.backgroundColor = .clear
        NoteText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        NoteText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        NoteText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        NoteText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
    func tableviewLayout() {
       
        NoteTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        NoteTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        NoteTableView.topAnchor.constraint(equalTo: NoteText.bottomAnchor, constant: 20).isActive = true
        NoteTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let object = MainViewModel.VM.wordlist[indexPath.row] /// NSManagedObject객체
        if MainViewModel.VM.delete(obejct: object) { /// DB에서 삭제
            MainViewModel.VM.wordlist.remove(at: indexPath.row) /// 데이터 삭제
           NoteTableView.deleteRows(at: [indexPath], with: .fade) /// 테이블 뷰에서 해당 행을 fade방법으로 제거
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       
        return MainViewModel.VM.wordlist.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //데이터 가져오기
        let record = MainViewModel.VM.wordlist[indexPath.row]
        
        let word = record.value(forKey: "word") as? String
        let contents = record.value(forKey: "wordcontents") as? String
        let wordidx = record.value(forKey: "wordidx") as? String
        
        let cell: ContentsCVNoteViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContentsCVNoteViewCell
        
        if MainViewModel.VM.wordlist.count == 0 {
            cell.textLabel?.text = "단어를 입력해주세요"
        }
        
        cell.wordLB.layer.borderWidth = 1
        
        if isCellup == false{
        
            cell.wordLB.text = word
            cell.wordLB.textAlignment = .center
            cell.wordLB.layer.borderWidth = 1
            cell.wordContentsLB.isHidden = true
            cell.wordContentsLB.alpha = 0
            cell.wordLB.transform = CGAffineTransform(translationX: 0, y: 0)
          
        }
        else {
            cell.wordLB.layer.borderWidth = 0
            cell.wordLB.text = wordidx
           
            cell.wordContentsLB.isHidden = false
            cell.wordContentsLB.text = contents
            cell.wordContentsLB.alpha = 0
            
            UIView.animate(withDuration: 0.5,
                animations: {
                    // 셀 단어 텍스트 이동 애니메이션
                    cell.wordLB.transform = CGAffineTransform(translationX: -170, y: -80)
                    cell.wordContentsLB.alpha = 1
                    })
            }
            return cell
            
        }
    
    
    // 셀을 선택했을때 선택한 셀의 행을 저장
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.NoteTableView.beginUpdates()
        
        //만약 현재 idx 가 selectedIndex 와 같다면
        if indexPath.row == selectedIndex {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
            
        }
        
        self.NoteTableView.endUpdates()
        // 0.25초후 reloadData, 셀이 펴지기 전에 리로드가 되면 펴지는 애니메이션이 나오지 않음.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            self.NoteTableView.reloadData()
        }

        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        
        if indexPath.row == selectedIndex
        {
            isCellup = true
            return 200
            
        }else {
            
            isCellup = false
            return 50
        }
        
    }
    
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}




