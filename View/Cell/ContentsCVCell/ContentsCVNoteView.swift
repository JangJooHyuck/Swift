//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import CoreData
import Combine

class ContentsCVNoteView:UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    private var cancellable = Set<AnyCancellable>()
    
    let NoteText = UILabel()
    let NoteTableView = UITableView()
    let deleteAll = UIButton()
    let sortList = UIButton()
    let sortList1 = UIButton()
    let sortList2 = UIButton()
    
    var heightAtIndexPath = NSMutableDictionary()
    //셀이 비어있나요?
    let emptyText = UILabel()
    //단어장이 비어있으니 추가하러 가시죠
    let goTomainBT = UIButton()
    
    
    //선택된 셀의 행이 뭔지 판단함.
    var selectedIndex: Int = -1
    // 셀이 커졌는지 ?
    var isCellup :Bool = false
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //다른곳에서 해당 테이블뷰를 리로드하기위함
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        emptyText.layer.zPosition = 99
        goTomainBT.layer.zPosition = 99
        
        self.addSubview(sortList)
        self.addSubview(sortList1)
        self.addSubview(sortList2)
        self.addSubview(deleteAll)
        self.addSubview(goTomainBT)
        self.addSubview(emptyText)
        self.addSubview(NoteText)
        self.addSubview(NoteTableView)
        
        sortList.translatesAutoresizingMaskIntoConstraints = false
        sortList1.translatesAutoresizingMaskIntoConstraints = false
        sortList2.translatesAutoresizingMaskIntoConstraints = false
        deleteAll.translatesAutoresizingMaskIntoConstraints = false
        goTomainBT.translatesAutoresizingMaskIntoConstraints = false
        emptyText.translatesAutoresizingMaskIntoConstraints = false
        
        NoteTableView.translatesAutoresizingMaskIntoConstraints = false
        NoteText.translatesAutoresizingMaskIntoConstraints = false
        
        self.NoteTableView.dataSource = self
        self.NoteTableView.delegate = self
        
        self.NoteTableView.register(ContentsCVNoteViewCell.self, forCellReuseIdentifier: "cell")
        
        DeleteAllBTLayout()
        tableviewLayout()
        textLayout()
        emptyTextLayout()
        gotomainLayout()
        HiddenTablewhenlistisEmpty()
        // VM에 있는 wordList 값이 바뀌면 리로드
        tableViewReload()
        sortListBTlayout()
        //sortBoolBinding()
     
    }
    //다른곳에서 해당 테이블뷰를 리로드하기위함
    @objc func loadList(notification: NSNotification){
        //load data here
       
        self.NoteTableView.reloadData()
        HiddenTablewhenlistisEmpty()
        
    }
    
    func sortListBTlayout(){
        // 버튼 타이틀
        sortList.setTitle("[최신순]", for: .normal)
        sortList.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sortList.titleLabel?.numberOfLines = 1
        sortList.titleLabel?.textAlignment = .center
        // 버튼 백그라운드 컬러 설정
        sortList.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        sortList.layer.cornerRadius = 0.2 * deleteAll.bounds.size.width
        sortList.clipsToBounds = true
        
        // 버튼 클릭시 repalaceAction 호출
        sortList.addTarget(self, action: #selector(sortAction), for: .touchUpInside)
        sortList.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortList.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sortList.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
       
        sortList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        sortList.layer.cornerRadius = 10
        
        sortList1.setTitle("[오래된순]", for: .normal)
        sortList1.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sortList1.titleLabel?.numberOfLines = 1
        sortList1.titleLabel?.textAlignment = .center
        // 버튼 백그라운드 컬러 설정
        sortList1.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        sortList1.layer.cornerRadius = 0.2 * deleteAll.bounds.size.width
        sortList1.clipsToBounds = true
        
        // 버튼 클릭시 repalaceAction 호출
        sortList1.addTarget(self, action: #selector(sortAction1), for: .touchUpInside)
        sortList1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortList1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sortList1.topAnchor.constraint(equalTo: sortList.bottomAnchor, constant: 5).isActive = true
       
        sortList1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        sortList1.layer.cornerRadius = 10
        
        sortList2.setTitle("[클릭순]", for: .normal)
        sortList2.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sortList2.titleLabel?.numberOfLines = 1
        sortList2.titleLabel?.textAlignment = .center
        // 버튼 백그라운드 컬러 설정
        sortList2.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        sortList2.layer.cornerRadius = 0.2 * deleteAll.bounds.size.width
        sortList2.clipsToBounds = true
        
        // 버튼 클릭시 repalaceAction 호출
        sortList2.addTarget(self, action: #selector(sortAction2), for: .touchUpInside)
        sortList2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortList2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sortList2.topAnchor.constraint(equalTo: sortList1.bottomAnchor, constant: 5).isActive = true
       
        sortList2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        sortList2.layer.cornerRadius = 10
    }

    
    
    @objc func sortAction(sender: UIButton!) {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 0.5  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        sortList.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.8)
        sortList1.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        sortList2.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
                //최신순
        MainViewModel.VM.sortSubject = "wordDate"
        MainViewModel.VM.sortBool = false
        MainViewModel.VM.wordlist = MainViewModel.VM.fetch()
        self.NoteTableView.reloadData()
    }
    @objc func sortAction1(sender: UIButton!) {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 0.5  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        sortList.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        sortList1.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.8)
        sortList2.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        
        MainViewModel.VM.sortSubject = "wordDate"
        MainViewModel.VM.sortBool = true
        MainViewModel.VM.wordlist = MainViewModel.VM.fetch()
        self.NoteTableView.reloadData()
       
    }
           
    // sort// 정렬기준
//    let sort = NSSortDescriptor(key: "wordDate", ascending: true)
//    fetchRequest.sortDescriptors = [sort]
//
//    let result = try! context.fetch(fetchRequest)
//    return result
    @objc func sortAction2(sender: UIButton!) {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 0.5  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        sortList.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        sortList1.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        sortList2.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.8)
        
        MainViewModel.VM.sortSubject = "wordcc"
        MainViewModel.VM.sortBool = false
        MainViewModel.VM.wordlist = MainViewModel.VM.fetch()
    }
    
    func DeleteAllBTLayout(){
        
    
        // 버튼 타이틀
        deleteAll.setTitle("단어 모두삭제", for: .normal)
        deleteAll.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        // 버튼 백그라운드 컬러 설정
        deleteAll.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        deleteAll.layer.cornerRadius = 0.2 * deleteAll.bounds.size.width
        deleteAll.clipsToBounds = true
        
        // 버튼 클릭시 repalaceAction 호출
        deleteAll.addTarget(self, action: #selector(DeleteAllAction), for: .touchUpInside)
        deleteAll.heightAnchor.constraint(equalToConstant: 130).isActive = true
        deleteAll.widthAnchor.constraint(equalToConstant: 100).isActive = true
        deleteAll.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
       
        deleteAll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        deleteAll.layer.cornerRadius = 10
    }
    @objc func DeleteAllAction(sender: UIButton!){
        
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        //삭제 액션

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NoteEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        // 저장소가져오기
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

        // 삭제실행
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }

        MainViewModel.VM.wordlist.removeAll()
        //모두다 삭제된건아닌지?
        HiddenTablewhenlistisEmpty()
        self.NoteTableView.reloadData()
    }
    
   
//    func sortBoolBinding(){
//        MainViewModel.VM.$sortBool.sink { value in
//            MainViewModel.VM.wordlist = MainViewModel.VM.fetch()
//            self.NoteTableView.reloadData()
//        }.store(in: &cancellable)
//    }
   
    // 리스트가 비어있으면 자동으로 테이블뷰 감추고 텍스트와 버튼 표시
    func HiddenTablewhenlistisEmpty(){
       
        if MainViewModel.VM.wordlist.isEmpty == true {
            NoteTableView.isHidden = true
            sortList.isHidden = true
            sortList1.isHidden = true
            sortList2.isHidden = true
            deleteAll.isHidden = true
            emptyText.isHidden = false
            goTomainBT.isHidden = false
            
        }
        
        else {
            NoteTableView.isHidden = false
            sortList.isHidden = false
            sortList1.isHidden = false
            sortList2.isHidden = false
            deleteAll.isHidden = false
            emptyText.isHidden = true
            goTomainBT.isHidden = true
        }
    }
  
    
    func textLayout() {
        NoteText.textAlignment = .center
        NoteText.font = UIFont.systemFont(ofSize: 50)
        NoteText.text = "단어장"
        NoteText.backgroundColor = .clear
        NoteText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        NoteText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        NoteText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 55).isActive = true
        NoteText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    }
    func emptyTextLayout(){
        emptyText.textAlignment = .center
        emptyText.font = UIFont.systemFont(ofSize: 30)
        emptyText.text = "단어장이 비어있습니다."
        emptyText.backgroundColor = .clear
        emptyText.widthAnchor.constraint(equalToConstant: 300).isActive = true
        emptyText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        emptyText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        emptyText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 250).isActive = true
        
    
    }
    func gotomainLayout(){
       
        goTomainBT.addTarget(self, action: #selector(gotoMainAction), for: .touchUpInside)
        goTomainBT.setTitle("단어추가하러 가기", for: .normal)
        goTomainBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        goTomainBT.layer.cornerRadius = 0.2 * goTomainBT.bounds.size.width
        goTomainBT.clipsToBounds = true
        goTomainBT.heightAnchor.constraint(equalToConstant: 100).isActive = true
        goTomainBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        goTomainBT.topAnchor.constraint(equalTo: emptyText.bottomAnchor, constant:50).isActive = true
        goTomainBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        goTomainBT.layer.cornerRadius = 10
        
        
    }
   
    
    @objc func gotoMainAction(sender: UIButton!){
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        // 버튼 클릭시 메인화면으로 이동
        ViewModel.VM.CurrentCell = 1
        print("gotoMain!")
    }
    
    func tableviewLayout() {
        NoteTableView.isScrollEnabled = true
        NoteTableView.flashScrollIndicators()
       
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
            self.NoteTableView.reloadData()
            HiddenTablewhenlistisEmpty()
        }
    }
    
    func tableViewReload(){
        MainViewModel.VM.$wordlist.sink { value in
         
            self.NoteTableView.reloadData()
            
            if value.isEmpty == true {
                self.NoteTableView.isHidden = true
                self.emptyText.isHidden = false
                self.goTomainBT.isHidden = false
            }
            
            else {
                self.NoteTableView.isHidden = false
                self.emptyText.isHidden = true
                self.goTomainBT.isHidden = true
            }
            
           
          
        }.store(in: &cancellable)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return MainViewModel.VM.wordlist.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //데이터 가져오기
        let record = MainViewModel.VM.wordlist[indexPath.row]
       
        // list배열 내부 타입은 NSManagedObject이기 때문에 원하는 적절한 캐스팅이 필요함
        let word = record.value(forKey: "word") as! String
        let contents = record.value(forKey: "wordcontents") as? String
        let wordcc = record.value(forKey: "wordcc")as! Int
       
        
        let cell: ContentsCVNoteViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContentsCVNoteViewCell
       
        cell.wordLB.layer.borderWidth = 1
        
        if isCellup == false{
        
            cell.wordLB.text = "\(word) ❤️\(wordcc)"
            cell.wordLB.textAlignment = .center
            cell.wordLB.layer.borderWidth = 1
            cell.wordContentsLB.isHidden = true
            cell.wordContentsLB.alpha = 0
            cell.wordLB.transform = CGAffineTransform(translationX: 0, y: 0)
            cell.wordLB.font = UIFont.systemFont(ofSize: 20)
            
        }
        else {
           
            cell.wordLB.layer.borderWidth = 0
            cell.wordLB.text = word
           
            cell.wordContentsLB.isHidden = false
            cell.wordContentsLB.text = contents
            cell.wordContentsLB.alpha = 0
            
            UIView.animate(withDuration: 0.5,
                animations: {
                    //단어의 따라 무브먼트 조정
                    
                    // 셀 단어 텍스트 이동 애니메이션
                    
                    cell.wordLB.font = UIFont.systemFont(ofSize: 40)
                    cell.wordLB.transform = CGAffineTransform(translationX: -140, y: -70)
                    
                    cell.wordContentsLB.alpha = 1
                    })
            }
            return cell
    }
        
    
    
    
    // 셀을 선택했을때 선택한 셀의 행을 저장
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //데이터 가져오기
        let record = MainViewModel.VM.wordlist[indexPath.row]
        
        
        self.NoteTableView.beginUpdates()
      
        
        //만약 현재 idx 가 selectedIndex 와 같다면
        if indexPath.row == selectedIndex {
            selectedIndex = -1
            MainViewModel.VM.wordlist = MainViewModel.VM.fetch()
            self.NoteTableView.reloadData()
        } else {
            selectedIndex = indexPath.row
            
            let object = MainViewModel.VM.wordlist[indexPath.row]
            // 현재 클릭 값 (바뀌기전)
            let currnetCC = (object.value(forKey: "wordcc") as? Int)!
            // 클릭한 이후 값 (바뀐 이후)
            let FlowCC = currnetCC + 1
            // 바뀐 이후 값을 wordcc 에 저장
            if NoteViewModel.VM.update(object: object, Click: FlowCC) == true {
                object.setValue(FlowCC, forKey: "wordcc")
                
            }
           
           
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




