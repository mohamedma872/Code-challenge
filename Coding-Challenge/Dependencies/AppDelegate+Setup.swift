//
//  AppDelegate+Setup.swift
//  iOSSampleApp
//
//  Created by Igor Kulman on 03/10/2017.
//  Copyright © 2017 Igor Kulman. All rights reserved.
//

import Foundation
import Swinject
extension AppDelegate {
    /**
     Set up the depedency graph in the DI container
     */
     func setupDependencies() {
     
        // services
        container.register(TaxiNetworkProtocal.self) { _ in TaxiNetworkManager()  }.inObjectScope(.container)
       
        // viewmodels
        container.register(BaseViewModel.self ,name:"TaxiViewModel") { r in TaxiViewModel(networkInstance: r.resolve(TaxiNetworkProtocal.self)!)  }.inObjectScope(.container)
        
        container.register(BaseViewModel.self,name:"TaxiMapViewModel") { r in TaxiMapViewModel(networkInstance: r.resolve(TaxiNetworkProtocal.self)!)  }.inObjectScope(.container)

    }
}
