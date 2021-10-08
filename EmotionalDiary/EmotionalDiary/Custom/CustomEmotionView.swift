//
//  CustomEmotionView.swift
//  EmotionalDiary
//
//  Created by Woochan Park on 2021/10/06.
//

import UIKit

final class CustomEmotionView: UIView {
  
  private let imageView: UIImageView!
  private let titleLabel: UILabel!
  private let tapGesture: UITapGestureRecognizer!
  
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
    
    imageView = UIImageView(image: image)
    titleLabel = UILabel()
    tapGesture = UITapGestureRecognizer()
    
    userDefaultskey = key
    
    super.init(frame:.zero)
    
    isUserInteractionEnabled = true
    
    addSubview(imageView)
    addSubview(titleLabel)
    
    addGestureRecognizer(tapGesture)
    tapGesture.addTarget(self, action: #selector(didTapCustomView))
    
    setUpImageView()
    setUpTitleLabel(with: title)
  }
  
  /**
    코드를 통한 초기화만 허용
   */
  required init?(coder: NSCoder) {
    fatalError("Init with Coder is not allowed.")
  }
  
  private func setUpImageView() {
    
    imageView.contentMode = .scaleAspectFit

    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 87/101).isActive = true
  }
  
  private func setUpTitleLabel(with text: String) {
    
    titleLabel.text = text
    titleLabel.textAlignment = .center
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
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
