//
//  TableView+Extension.swift
//  WeatherApp
//
//  Created by Volodymyr Seredovych on 07.01.2023.
//

import UIKit

extension UITableView {
    func reloadDataSavingSelections() {
        let selectedRows = indexPathsForSelectedRows
        reloadData()
        if let selectedRow = selectedRows {
            for indexPath in selectedRow {
                selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
        }
    }
}
