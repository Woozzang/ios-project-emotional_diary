//
//  DiaryMainViewController.swift
//  EmotionalDiary
//
//  Created by Woochan Park on 2021/10/06.
//

import UIKit

class DiaryMainViewController: UIViewController {
  
  let emotiontitleList: [String] = [
    "행복해", "사랑해", "좋아해",
    "당황해", "속상해", "우울해",
    "심심해", "별로야", "슬퍼요"
  ]
  @IBOutlet var horizontalStackViews: [UIStackView]!
  
  @IBOutlet weak var verticalStackView: UIStackView!
  
  @IBOutlet weak var navigationBar: UINavigationBar! {
    didSet {
      
      let customAppearance = UINavigationBarAppearance()
      
      customAppearance.configureWithTransparentBackground()
      
      navigationBar.standardAppearance = customAppearance

      navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: nil)
      
      navigationBar.tintColor = .white
      
      navigationBar.topItem?.title = "Emotional Diary"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

        // Do any additional setup after loading the view.
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCustomViewNotification(_:)), name: CustomEmotionView.didTapCustomView, object: nil)
    
    fillStackView()
  }
  
  @objc func didReceiveCustomViewNotification(_ noti: Notification) {
    
    let customView = noti.object as! CustomEmotionView
    
//    guard let title = customView.titleLabel.text else { fatalError(#function) }
    
    let originValue = UserDefaults.standard.integer(forKey: customView.userDefaultskey)
    
    print(originValue)
    
    UserDefaults.standard.set(originValue + 1, forKey: customView.userDefaultskey)
    
    customView.titleText = customView.userDefaultskey + "\(originValue + 1)"
    
  }
  /**
   타이틀에 필요한 텍스트를 만들어준다.
   
   - 필요한 데이터
   1. 감정이름을 Key 로 하는 UserDefaults 의 Value 값
   2. 감정이름
   
   */
  
  private func makeTitleForEmotionView(with index: Int) -> String {
    
    let baseString = emotiontitleList[index]
    
    let count = UserDefaults.standard.integer(forKey: baseString)
    
    return "\(baseString) \(count)"
  }
  
  
  func fillStackView(){
    
    for rowIndex in (0...2) {

      for columnIndex in (0...2) {
        
        let baseValue = 3 * rowIndex
        
        let columnIndex = baseValue + columnIndex
        
        let image = UIImage(named: "mono_slime\(columnIndex + 1)")!
        
        let title = makeTitleForEmotionView(with: columnIndex)

        let customView = CustomEmotionView(image: image, title: title, key: self.emotiontitleList[columnIndex])
        
        horizontalStackViews[rowIndex].addArrangedSubview(customView)
        
      }
    }
  }
}
