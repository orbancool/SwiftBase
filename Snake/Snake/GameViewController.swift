//
//  GameViewController.swift
//  Snake
//
//  Created by Irina Semenova on 04/11/2019.
//  Copyright © 2019 Denis Semenov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gameScane = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        gameScane.scaleMode = .resizeFill
        skView.presentScene(gameScane)
    }

}
