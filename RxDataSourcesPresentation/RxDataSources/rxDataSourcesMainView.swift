//
//  rxDataSourcesMainView.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/26/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class RxDataSourcesMainView: UIView {
    
    private let disposeBag = DisposeBag()
    let tiledTableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
        self.configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        self.backgroundColor = .blue
        self.configureTiledTableView()
    }
    
    private func configureTiledTableView() {
        self.tiledTableView.backgroundColor = .blue
        self.tiledTableView.register(ScrollListTileCell.self, forCellReuseIdentifier: "DataSourcesCell")
        self.tiledTableView.rowHeight = 150
        self.tiledTableView.separatorStyle = .none
        self.tiledTableView.showsVerticalScrollIndicator = true
    }
    
    private func configureConstraints() {
        self.addSubview(self.tiledTableView)
        
        self.tiledTableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

