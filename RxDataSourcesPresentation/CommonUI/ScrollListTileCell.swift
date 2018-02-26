//
//  commonUI.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/26/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ScrollListTileCell: UITableViewCell {
    private let tileButton = RoundedGreenButton()
    private let infoLabel = UILabel()
    
    var didSelectCell: Observable<Void> { return self.tileButton.rx.tap.asObservable() }
    var isTileSelected: Bool {
        get {
            return self.tileButton.isSelected
        } set {
            self.tileButton.isSelected = newValue
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureSelf()
        self.configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = UIEdgeInsetsInsetRect(
            contentView.frame,
            UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        )
    }
    
    func configure(tileText: String?, infoLabel: String) {
        self.tileButton.setTitle(tileText, for: .normal)
        self.infoLabel.text = infoLabel
    }
    
    private func configureSelf() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func configureConstraints() {
        self.contentView.addSubview(self.tileButton)
        self.contentView.addSubview(self.infoLabel)
        
        self.tileButton.snp.makeConstraints {
            $0.height.equalTo(self.tileButton.snp.width)
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.infoLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.tileButton)
            $0.leading.equalTo(self.tileButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview()
        }
    }
}

