//
//  Land.swift
//  MyGame
//
//  Created by Alexander Litvinov on 25.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Land: SKSpriteNode, GameObjectsSpriteable {
    
    static func set(at point: CGPoint?) -> Land {
        
        let land = Land()
        land.size = CGSize(width: Constants.Land.width , height: Constants.Land.height)
        land.color = .white
        land.name = "myLand"
        
        guard let point = point else { return land }
        land.position = point
        
        land.physicsBody = SKPhysicsBody(rectangleOf: land.size)
        land.physicsBody?.categoryBitMask = BitMaskCategory.Land
        land.physicsBody?.collisionBitMask = BitMaskCategory.Ball
        land.physicsBody?.contactTestBitMask = BitMaskCategory.Ball
        land.physicsBody?.affectedByGravity = false
        land.physicsBody?.isDynamic = false
        
        return land
    }
}

