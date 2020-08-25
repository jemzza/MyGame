//
//  BitMaskCategory.swift
//  MyGame
//
//  Created by Alexander Litvinov on 24.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import Foundation

struct BitMaskCategory {
    
    static let Ball: UInt32 = 0x1 << 1
    static let Land: UInt32 = 0x1 << 2
    static let Obstrucion: UInt32 = 0x1 << 3
    static let Score: UInt32 = 0x1 << 4
    static let Check: UInt32 = 0x1 << 5
}
