//
//  GameObjectsSpriteable.swift
//  MyGame
//
//  Created by Alexander Litvinov on 25.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import Foundation
import CoreGraphics

protocol GameObjectsSpriteable {
    static func set(at point: CGPoint?) -> Self
}
