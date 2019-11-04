//
//  GameScene.swift
//  Snake
//
//  Created by Irina Semenova on 04/11/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        view.showsPhysics = true
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        // устанавливаем категории, с которыми будут пересекаться края сцены
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead


        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        counterClockwiseButton.fillColor = .gray
        counterClockwiseButton.name = "Left"
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view.scene!.frame.maxX-30-45, y: view.scene!.frame.minY+30)
        clockwiseButton.fillColor = .gray
        clockwiseButton.name = "Right"
        
        addChild(counterClockwiseButton)
        addChild(clockwiseButton)
        
        createApple()
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
    }
    
    func createApple() {
        let x = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)))
        let y = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)))
        let apple = Apple(position: CGPoint(x: x, y: y))
        addChild(apple)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "Left" || touchedNode.name == "Right" else {
                    return
            }
            touchedNode.fillColor = .green
            
            if touchedNode.name == "Left" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "Right" {
                snake!.moveClockwise()
            }
        }



    }
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                touchedNode.name == "Left" || touchedNode.name == "Right" else {
                    return
            }
            touchedNode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
     
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake!.move()
        

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // логическая сумма масок соприкоснувшихся объектов
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        // вычитаем из суммы голову змеи, и у нас остается маска второго объекта
        let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        // проверяем, что это за второй объект
        switch collisionObject {
        case CollisionCategories.Apple: // проверяем, что это яблоко
            // яблоко – это один из двух объектов, которые соприкоснулись. Используем тернарный оператор, чтобы вычислить, какой именно
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            // добавляем к змее еще одну секцию
            snake?.addBodyPart()
            // удаляем съеденное яблоко со сцены
            apple?.removeFromParent()
            // создаем новое яблоко
            createApple()
        case CollisionCategories.EdgeBody:
            snake?.removeAllChildren()
            snake?.removeFromParent()
            snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
            self.addChild(snake!)
            //createApple()
            // проверяем, что это стенка экрана
            //break                         // соприкосновение со стеной будет домашним заданием
        default:
            break
        }
    }

}
