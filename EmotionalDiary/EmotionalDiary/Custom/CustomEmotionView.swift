//
//  CustomEmotionView.swift
//  EmotionalDiary
//
//  Created by Woochan Park on 2021/10/06.
//

import UIKit

final class CustomEmotionView: UIView {
  
  private let imageView: UIImageView = UIImageView()
  private let titleLabel: UILabel = UILabel()
  private let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
  
  let userDefaultskey: String
  let predefinedFrameWidth: CGFloat = 118
  let predefinedFrameHeight: CGFloat = 110
  
  var titleText: String? {
    get {
      return titleLabel.text
    }
    set {
      titleLabel.text = newValue
    }
  }
  
  init(image: UIImage, title: String, key: String) {
    
    self.userDefaultskey = key
    
    super.init(frame:.zero)
    
    self.isUserInteractionEnabled = true
    
    self.imageView.image = image
    self.imageView.contentMode = .scaleAspectFit
    

    self.titleLabel.text = title
    self.titleLabel.textAlignment = .center
    
    self.addGestureRecognizer(tapGesture)
    self.tapGesture.addTarget(self, action: #selector(didTapCustomView))
    
    self.addSubview(imageView)
    self.addSubview(titleLabel)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    setUpBoundsConstraint()
    setUpSubviews()
  }
  
  /**
    코드를 통한 초기화만 허용
   */
  required init?(coder: NSCoder) {
    fatalError("Init with Coder is not allowed.")
  }
  
  private func setUpBoundsConstraint() {
    
//    self.widthAnchor.constraint(lessThanOrEqualToConstant: predefinedFrameWidth).isActive = true
//
//    self.heightAnchor.constraint(lessThanOrEqualToConstant: predefinedFrameHeight).isActive = true
    
    self.widthAnchor.constraint(equalToConstant: predefinedFrameWidth).isActive = true
    self.heightAnchor.constraint(equalToConstant: predefinedFrameHeight).isActive = true
  }
  
  private func setUpSubviews() {

    imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
    imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8).isActive = true


    titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

  }
  
  @objc func didTapCustomView() {
    
    NotificationCenter.default.post(name: CustomEmotionView.didTapCustomView, object: self)
  }

}

extension CustomEmotionView {
  static let didTapCustomView: Notification.Name = Notification.Name.init("didTapCustomView")
}
