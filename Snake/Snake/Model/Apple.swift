import UIKit
import SpriteKit

class Apple: SKShapeNode {
    
    convenience init(position: CGPoint) {
        self.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .red
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x:5, y:5))
        // Категория - яблоко
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
    

        
    }
}
