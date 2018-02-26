//
//  ViewController.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/26/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit
import RxSwift
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.dataSource.configureCell = { (ds, tv, ip, item) in
            guard let cell = tv.dequeueReusableCell(withIdentifier: "DataSourcesCell", for: ip) as? ScrollListTileCell else {
                    return ScrollListTileCell(style: .default, reuseIdentifier: "DataSourcesCell")
            }
            cell.configure(tileText: item.tileText, infoLabel: item.infoText)
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
        Observable.just([
            SectionOfRecords(header: "", items: [
                Record(tileText: "0", infoText: "aaaa"),
                Record(tileText: "1", infoText: "bbbb"),
                Record(tileText: "2", infoText: "cccc"),
                Record(tileText: "3", infoText: "dddd")
                ])
            ]).bind(to: self.mainView.tiledTableView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }
}
