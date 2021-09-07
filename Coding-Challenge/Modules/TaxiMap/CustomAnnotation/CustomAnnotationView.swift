//
//  CustomAnnotationView.swift
//  Coding-Challenge
//
//  Created by Mohamed Elsdody on 06/09/2021.
//

import Foundation
import MapKit
class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
    var heading: String!
}
class CustomAnnotationView : MKPinAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    static var identifier: String {
        return String(describing: self)
    }
    
}
