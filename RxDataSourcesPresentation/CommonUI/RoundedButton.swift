//
//  RoundedButton.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/26/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RoundedGreenButton: UIButton {
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        self.configure()
    }
    
    override var isEnabled: Bool { didSet { self.setupColorForState() }}
    override var isHighlighted: Bool { didSet { self.setupColorForState() }}
    override var isSelected: Bool { didSet { self.setupColorForState() }}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.black, for: .highlighted)
        self.setTitleColor(.black, for: .selected)
        self.setTitleColor(.white, for: .disabled)
        self.contentMode = .center
        layer.cornerRadius = 8
        setupColorForState()
        self.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.isSelected = !self.isSelected
        }).disposed(by: disposeBag)
    }
    
    private func setupColorForState() {
        if isSelected {
            backgroundColor = .yellow
        } else if isHighlighted {
            backgroundColor = .yellow
        } else {
            backgroundColor = .green
        }
    }
}

