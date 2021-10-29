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
    let userDefault = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player = player{
            playerNameLabel.text = player.name
            scoreLabel.text = player.score.description
            updateScoreRanking(player)
            
        }
        
        view.insertSubview(produceBackground(view.frame), at: 0)
    }
    
    
    @IBAction func showScoreRanking(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "\(ScoreViewController.self)") else { return }
        present(controller, animated: true, completion: nil)
    }
    
    func updateScoreRanking(_ player: PlayerInfo){
        var rankPlayers = [PlayerInfo]()
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        //get history rank player
        for playerRankKey in PlayerRankKey.allCases{
            guard let data = userDefault.data(forKey: playerRankKey.rawValue),
                  let rankPlayer = try? decoder.decode(PlayerInfo.self, from: data)
            else {
                print("no more data!!!")
                break
            }
           //add history rank player to array
            rankPlayers.append(rankPlayer)
            
        }
        
        //add current palyer
        rankPlayers.append(player)
        
        //sort player score
        rankPlayers.sort { $0.score >= $1.score}
        
        //save rank player
        var idx = 0
        for playerRankKey in PlayerRankKey.allCases {
            if idx < rankPlayers.count{
                if let data = try? encoder.encode(rankPlayers[idx]) {
                userDefault.setValue(data, forKey: playerRankKey.rawValue)
                }
                idx += 1
            }
            else{
                break
            }
        }
     
        
        
    }
    
}
