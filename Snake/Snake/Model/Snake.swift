import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    let diameter = 10.0
    // добавляем конструктор
    init (atPoint point: CGPoint){
        super.init()
        // Создаем физическое тело
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter - 4), center: CGPoint(x: 5, y:5))
        // Может перемещаться в пространстве
        self.physicsBody?.isDynamic = true
        // Категория - змея
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        // пересекается с границами экрана и яблоком
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
    

        //self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x:5, y:5))
        // рисуем круглый элемент
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diameter), height: CGFloat(diameter))).cgPath
        // цвет рамки и заливки зеленый
        fillColor = UIColor.green
        strokeColor = UIColor.green
        // ширина рамки 5 поинтов
        lineWidth = 5
        // размещаем элемент в переданной точке
        self.position = point
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint){
        super.init(atPoint:point)
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        // пересекается с телом, яблоком и границей экрана
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple | CollisionCategories.Snake

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Snake: SKShapeNode {
    // массив, где хранятся сегменты тела
    var body = [SnakeBodyPart]()
    // конструктор
    // скорость перемещения
    let moveSpeed = 125.0
    // угол, необходимый для расчета направления
    var angle: CGFloat = 0.0
    
    func move(){
        // если у змейки нет головы, ничего не перемещаем
        guard !body.isEmpty else { return }
        // перемещаем голову
        let head = body[0]
        moveHead(head)
        // перемещаем все сегменты тела
        for index in (0..<body.count) where index > 0 {
            let previousBodyPart = body[index-1]
            let currentBodyPart = body[index]
            moveBodyPart(previousBodyPart, c: currentBodyPart)
        }
    }
    
    
    func moveHead(_ head: SnakeBodyPart){
        // рассчитываем смещение точки
        let dx = CGFloat(moveSpeed) * sin(angle);
        let dy = CGFloat(moveSpeed) * cos(angle);
        // смещаем точку назначения головы
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        // действие перемещения головы
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        // запуск действия перемещения
        head.run(moveAction)
    }
    
    func moveBodyPart(_ p: SnakeBodyPart, c: SnakeBodyPart){
        // перемещаем текущий элемент к предыдущему
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1 )
        // запуск действия перемещения
        c.run(moveAction)
    }
    // поворот по часовой стрелке
    func moveClockwise(){
        // смещаем угол на 45 градусов
        angle += CGFloat(Double.pi/2)
    }
    // поворот против часовой стрелки
    func moveCounterClockwise(){
        angle -= CGFloat(Double.pi/2)
    }

    
    convenience init(atPoint point: CGPoint) {
        self.init()
        // змейка начинается с головы, создадим ее
        let head = SnakeHead(atPoint: point)
        // и добавим в массив
        body.append(head)
        // и сделаем ее дочерним объектом.
        addChild(head)
    }
    // метод добавляет еще один сегмент тела
    func addBodyPart(){
        // инстанцируем сегмент
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        // добавляем его в массив
        body.append(newBodyPart)
        // делаем дочерним объектом
        addChild(newBodyPart)
    }
}

