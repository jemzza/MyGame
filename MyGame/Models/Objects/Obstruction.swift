//
//  Obstruction.swift
//  MyGame
//
//  Created by Alexander Litvinov on 25.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit

//MARK:- TODO
/*
final class Obstruction: SKSpriteNode, GameObjectsSpriteable {
    
    static func set(at point: CGPoint?) -> Obstruction {
        
        let obstruction = Obstruction()
        obstruction.color = .red
        obstruction.size = CGSize(width: 100, height: 100)

        guard let point = point else { return ball }
        obstruction.position = point
        
        obstruction.physicsBody = SKPhysicsBody(rectangleOf: obstruction.size)
        obstruction.physicsBody?.categoryBitMask = BitMaskCategory.Obstrucion
        obstruction.physicsBody?.collisionBitMask = BitMaskCategory.Ball
        obstruction.physicsBody?.contactTestBitMask = BitMaskCategory.Ball
        obstruction.physicsBody?.isDynamic = false
        obstruction.physicsBody?.affectedByGravity = false
        
        return obstruction
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint, time: TimeInterval) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: point.y)
        let moveDistance = point.x + 200
        let movementSpeed: CGFloat = 100.0 + 5.0 * CGFloat(time)
        let duration = moveDistance / movementSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
*/
