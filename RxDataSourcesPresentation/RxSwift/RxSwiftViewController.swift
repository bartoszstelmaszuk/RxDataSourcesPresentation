//
//  RxSwiftViewController.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/27/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit
import RxSwift

class RxSwiftViewController: UIViewController {
    
    private var mainView: RxSwiftMainView {
        guard let view = view as? RxSwiftMainView else { fatalError("View not found") }
        return view
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = RxSwiftMainView()
    }
}

