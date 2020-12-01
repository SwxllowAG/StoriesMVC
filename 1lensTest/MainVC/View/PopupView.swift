//
//  PopupView.swift
//  1lensTest
//
//  Created by Galym Anuarbek on 2/11/20.
//  Copyright © 2020 Galym Anuarbek. All rights reserved.
//

import UIKit
import EasyPeasy
import Kingfisher

class PopupView: UIView {
    
    var video: Video? {
        didSet {
            if let thumb = video?.thumb, let url = URL(string: Media.baseImgUrl + thumb) {
                self.thumbView.kf.setImage(with: url)
            }
            self.titleLabel.text = video?.title
            self.subtitleLabel.text = video?.subtitle
        }
    }
    
    let thumbView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 18
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 15)
        l.textColor = UIColor.white
        return l
    }()
    
    let subtitleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = UIColor.white
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(thumbView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        backgroundColor = .clear
        
        self.isUserInteractionEnabled = false
        let gl = CAGradientLayer()
        gl.frame = self.frame
        gl.colors = [UIColor.black.withAlphaComponent(0.55).cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.55).cgColor]
        layer.insertSublayer(gl, at: 0)
    }
    
    func setupConstraints() {
        let topMargin = UIApplication.shared.statusBarFrame.height
        thumbView.easy.layout(Left(24), Top(topMargin + 24), Width(36), Height(36))
        titleLabel.easy.layout(Left(10).to(thumbView), Top(topMargin + 24), Right(36), Height(18))
        subtitleLabel.easy.layout(Left(10).to(thumbView), Top(0).to(titleLabel), Right(36), Height(18))
    }
}
