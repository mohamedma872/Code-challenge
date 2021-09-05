//
//  BaseViewModel.swift
//  Nutrition-Analysis
//
//  Created by Mohamed Elsdody on 22/08/2021.
//

import Foundation
import RxSwift
protocol BaseViewModel {
    var onShowLoading: Observable<Bool> { get }
    var onShowError: PublishSubject<String> { get }
}
