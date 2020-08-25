//
//  Ball.swift
//  MyGame
//
//  Created by Alexander Litvinov on 25.08.2020.
//  Copyright © 2020 Alexander Litvinov. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Ball: SKShapeNode, GameObjectsSpriteable {
    
    static func set(at point: CGPoint?) -> Ball {
        
        let ball = Ball(circleOfRadius: Constants.Ball.diameter / 2)
        
        ball.position = CGPoint(x: 0, y: 0 )
        ball.fillColor = SKColor.white
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.height / 2)
        ball.physicsBody?.categoryBitMask = BitMaskCategory.Ball
        ball.physicsBody?.collisionBitMask = BitMaskCategory.Land | BitMaskCategory.Obstrucion
        ball.physicsBody?.contactTestBitMask = BitMaskCategory.Land | BitMaskCategory.Obstrucion | BitMaskCategory.Score
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true

        guard let point = point else { return ball }
        ball.position = point
        ball.zPosition = 2

        
        return ball
    }
}
