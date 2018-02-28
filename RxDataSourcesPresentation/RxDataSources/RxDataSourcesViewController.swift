//
//  ViewController.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/26/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxDataSourceViewController: UIViewController {
    
    private var mainView: RxDataSourcesMainView {
        guard let view = view as? RxDataSourcesMainView else { fatalError("View not found") }
        return view
    }
    
    private let disposeBag = DisposeBag()
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionOfRecords>(
        configureCell: { (_, _, _, _) in fatalError("Used before configured")}
    )
    
    private let dataRelay = BehaviorRelay<[SectionOfRecords]>(value: [
        SectionOfRecords(header: "", items: [
            Record(tileText: "0", infoText: "aaaa", isSelected: false),
            Record(tileText: "1", infoText: "bbbb", isSelected: false),
            Record(tileText: "2", infoText: "cccc", isSelected: false),
            Record(tileText: "3", infoText: "dddd", isSelected: false),
            Record(tileText: "4", infoText: "eeee", isSelected: false),
            Record(tileText: "5", infoText: "ffff", isSelected: false),
            Record(tileText: "6", infoText: "gggg", isSelected: false)
            ])
        ])
        
    init() {
        super.init(nibName: nil, bundle: nil)
        self.dataSource.configureCell = { (ds, tv, ip, item) in
            guard let cell = tv.dequeueReusableCell(withIdentifier: "DataSourcesCell", for: ip) as? ScrollListTileCell else {
                    return ScrollListTileCell(style: .default, reuseIdentifier: "DataSourcesCell")
            }
            cell.configure(tileText: item.tileText, infoLabel: item.infoText, isSelected: item.isSelected, updateSelectionState: { [weak self] isSelected in
                guard let `self` = self else { return }
                var copy = self.dataRelay.value
                copy[0].items[ip.row].isSelected = !copy[0].items[ip.row].isSelected
                self.dataRelay.accept(copy)
            })
            return cell
        }
        self.subscibeToUserEvents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = RxDataSourcesMainView()
    }
    
    private func subscibeToUserEvents() {
        dataRelay.asObservable()
            .bind(to: self.mainView.tiledTableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
}
