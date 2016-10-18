//
//  GameScene.swift
//  DevMtnPool
//
//  Created by Jake Gundersen on 10/17/16.
//  Copyright © 2016 Jake Gundersen. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var cueBall : SKSpriteNode?
    var contacts = [SKPhysicsContact]()
    var startPos : CGPoint?
    var endPos : CGPoint?
    
    var line = SKSpriteNode()
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    
    
    override func didMove(to view: SKView) {
        cueBall = scene?.childNode(withName: "CueBall") as! SKSpriteNode?
        scene?.physicsWorld.contactDelegate = self
        addChild(line)
        line.color = UIColor.white
        
        scene?.enumerateChildNodes(withName: "balls", using: { (ball, _) in
            if let colorBall = ball as? SKSpriteNode {
                colorBall.color = UIColor.randomColor()
                colorBall.colorBlendFactor = 0.8
            }
        })
    }
    
    func drawLine(startPoint : CGPoint, endPoint : CGPoint) {
        let length = startPoint.distanceTo(point: endPoint)
        let height = 2.0
        let angle = (endPoint - startPoint).angle
        line.size = CGSize(width: length, height: CGFloat(height))
        line.zRotation = angle
        line.position = (startPoint + endPoint) / 2.0
    }
    
    func touchDown(atPoint pos : CGPoint) {
        startPos = pos
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        endPos = pos
        line.isHidden = false
        if let start = startPos,
            let end = endPos {
            drawLine(startPoint: start, endPoint: end)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let startPos = startPos {
            let diffPoint = pos - startPos
            let forceVector = CGVector(dx: -diffPoint.x, dy: -diffPoint.y)
            applyForce(force: forceVector, atPoint: pos)
        }
        line.isHidden = true
    }
    
    func applyForce(force : CGVector, atPoint: CGPoint) {
        cueBall?.physicsBody?.applyImpulse(force, at: atPoint)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        contacts.append(contact)
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if let index = contacts.index(of: contact) {
            contacts.remove(at: index)
        }
    }
    
    func updateBalls() {
        for contact in contacts {
            ballFallsInHole(contact: contact)
        }
    }
    
    func ballFallsInHole(contact : SKPhysicsContact) {
        var ball : SKPhysicsBody?
        var hole : SKPhysicsBody?
        
        if (contact.bodyA.node?.name == "balls" && contact.bodyB.node?.name == "hole") {
            ball = contact.bodyA
            hole = contact.bodyB
        } else if (contact.bodyB.node?.name == "balls" && contact.bodyA.node?.name == "hole") {
            ball = contact.bodyB
            hole = contact.bodyA
        }
        if let ball = ball,
            let hole = hole,
            let ballNode = ball.node,
            let holeNode = hole.node {
            
            let ballRadius = ballNode.frame.size.width / 2.0
            let ballPosition = ballNode.position
            
            let holeRadius = holeNode.frame.size.width / 2.0
            let holePosition = holeNode.position
            
            let distance = ballPosition.distanceTo(point: holePosition)
            if (distance + ballRadius < holeRadius) {
                ballNode.removeFromParent()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        updateBalls()
    }
}
