//
//  record.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/26/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import RxDataSources

struct Record {
    let tileText: String
    let infoText: String
}

struct SectionOfRecords {
    var header: String
    var items: [Item]
}

extension SectionOfRecords: SectionModelType {
    typealias Item = Record
    
    init(original: SectionOfRecords, items: [Item]) {
        self = original
        self.items = items
    }
}
