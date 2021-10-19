//
//  ResultViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/9.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var player : PlayerInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player = player{
            playerNameLabel.text = player.name
            scoreLabel.text = player.score.description
        }
        
        view.insertSubview(produceBackground(view.frame), at: 0)
    }
    
    
    
}
