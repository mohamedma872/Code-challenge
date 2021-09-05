//
//  TaxiCellViewModel.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 05/09/2021.
//

import Foundation
struct TaxiCellViewModel {
    var id: Int?
    var status: String?
    var type: String?
   
    init(model : PoiList?) {
        self.id = model?.id
        self.status = model?.state?.rawValue ?? "-"
        self.type = model?.type?.rawValue ?? "-"        
    }
}

