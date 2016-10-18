//
//  GameScene.swift
//  DevMtnPool
//
//  Created by Jake Gundersen on 10/17/16.
//  Copyright © 2016 Jake Gundersen. All rights reserved.
//

import SpriteKit
import GameplayKit

//CGPoint extensions
public extension CGPoint {
    public func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    public func distanceTo(point: CGPoint) -> CGFloat {
        return (self - point).length()
    }
    
    public var angle: CGFloat {
        return atan2(y, x)
    }
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

public func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

extension UIColor {
    class func randomColor() -> UIColor {
        let hue = CGFloat(arc4random() % 256) / 256.0
        let saturation = 0.8
        let brightness = 0.8
        return UIColor(hue: hue, saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1.0)
    }
}

class GameScene: SKScene {

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
       
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
