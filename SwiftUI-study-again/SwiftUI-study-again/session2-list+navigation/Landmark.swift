//
//  Landmark.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/02/04.
//

import Foundation


struct Landmark {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    var coordinate: (latt: Double, long: Double)
    
    
    static func makeDummies(size: Int) -> [Landmark] {
        return (0..<size).map(dummy(_:))
    }
    
    static func dummy(_ int: Int) -> Landmark {
        Landmark(
            id: int,
            name: "mark:\(int)",
            park: "park:\(int)",
            state: "state:\(int)",
            description: "desc:\(int)",
            coordinate: (100 + Double(int), 100 + Double(int) )
        )
    }
}
