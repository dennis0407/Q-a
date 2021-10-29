//
//  ScoreViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/10/23.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet var playerLabels: [UILabel]!
    let userDefault = UserDefaults()
   
    @IBOutlet var scoreLabels: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlayerRank()
    }
    
    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getPlayerRank(){
        let decoder = JSONDecoder()
        
        for playerRankKey in PlayerRankKey.allCases{
            
            //get player info from userdefault
            guard let data = userDefault.data(forKey: playerRankKey.rawValue),
                  let rankPlayer = try? decoder.decode(PlayerInfo.self, from: data)
            else {
                print("get data fail !!!")
                return
            }
            
            switch playerRankKey{
            case .first:
                if let playerLabel = searchLabel(labels: playerLabels, id: "player1Label"){
                    playerLabel.text = rankPlayer.name
                }
                
                if let scoreLabel = searchLabel(labels: scoreLabels, id: "score1Label"){
                    scoreLabel.text = rankPlayer.score.description
                }
                
            case .second:
                if let playerLabel = searchLabel(labels: playerLabels, id: "player2Label"){
                    playerLabel.text = rankPlayer.name
                }
                
                if let scoreLabel = searchLabel(labels: scoreLabels, id: "score2Label"){
                    scoreLabel.text = rankPlayer.score.description
                }
                
            case .third:
                if let playerLabel = searchLabel(labels: playerLabels, id: "player3Label"){
                    playerLabel.text = rankPlayer.name
                }
                
                if let scoreLabel = searchLabel(labels: scoreLabels, id: "score3Label"){
                    scoreLabel.text = rankPlayer.score.description
                }
            case .fouth:
                if let playerLabel = searchLabel(labels: playerLabels, id: "player4Label"){
                    playerLabel.text = rankPlayer.name
                }
                
                if let scoreLabel = searchLabel(labels: scoreLabels, id: "score4Label"){
                    scoreLabel.text = rankPlayer.score.description
                }
            case .fifth:
                if let playerLabel = searchLabel(labels: playerLabels, id: "player5Label"){
                    playerLabel.text = rankPlayer.name
                }
                
                if let scoreLabel = searchLabel(labels: scoreLabels, id: "score5Label"){
                    scoreLabel.text = rankPlayer.score.description
                }
            }
        
        
        }
    }
    
    func searchLabel(labels: [UILabel], id: String) -> UILabel?{
        
        
        for label in labels{
            if label.restorationIdentifier == id{
                return label
            }
        }
        
        return nil
    }
    

}
