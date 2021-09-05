//
//  TaxiViewModel.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import Foundation
enum TaxiTableViewCellType {
    case normal(cellViewModel: TaxiCellViewModel)
    case error(message: String)
    case empty
}
