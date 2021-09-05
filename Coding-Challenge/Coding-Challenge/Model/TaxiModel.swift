//
//  TaxiModel.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 04/09/2021.
//
// To parse the JSON, add this file to your project and do:
//
//   let taxiModel = try? newJSONDecoder().decode(TaxiModel.self, from: jsonData)

import Foundation

// MARK: - TaxiModel
struct TaxiModel: Codable {
    let poiList: [PoiList]?
}

// MARK: - PoiList
struct PoiList: Codable {
    let id: Int?
    let coordinate: Coordinate?
    let state: State?
    let type: TypeEnum?
    let heading: Double?
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let latitude, longitude: Double?
}

enum State: String, Codable {
    case active = "ACTIVE"
    case inActive = "INACTIVE"
}

enum TypeEnum: String, Codable {
    case taxi = "TAXI"
}

