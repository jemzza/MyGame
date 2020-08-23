//
//  Random.swift
//  MyGame
//
//  Created by Alexander Litvinov on 23.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    static func random(min : CGFloat, max : CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
    
    
}
