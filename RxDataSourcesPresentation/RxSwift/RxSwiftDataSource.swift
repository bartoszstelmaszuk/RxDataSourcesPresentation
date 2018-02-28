//
//  RxSwiftDataSource.swift
//  RxDataSourcesPresentation
//
//  Created by Bartosz Stelmaszuk on 2/27/18.
//  Copyright © 2018 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class RxSwiftDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var cells = [
        Record(tileText: "0", infoText: "aaaa", isSelected: false),
        Record(tileText: "1", infoText: "bbbb", isSelected: false),
        Record(tileText: "2", infoText: "cccc", isSelected: false),
        Record(tileText: "3", infoText: "dddd", isSelected: false),
        Record(tileText: "4", infoText: "eeee", isSelected: false),
        Record(tileText: "5", infoText: "ffff", isSelected: false),
        Record(tileText: "6", infoText: "gggg", isSelected: false)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cells.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftCell", for: indexPath) as? ScrollListTileCell else {
            return ScrollListTileCell(style: .default, reuseIdentifier: "SwiftCell")
        }
        
        cell.configure(
            tileText: cells[indexPath.row].tileText,
            infoLabel: cells[indexPath.row].infoText,
            isSelected: cells[indexPath.row].isSelected,
            updateSelectionState: { [weak self] isSelected in
                cell.isTileSelected = !isSelected
                self?.updateCell(indexPath: indexPath, to: !isSelected)
        })
        return cell
    }
    
    private func updateCell(indexPath: IndexPath, to value: Bool) {
        self.cells[indexPath.row].isSelected = value
    }
}
