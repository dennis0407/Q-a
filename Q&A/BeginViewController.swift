//
//  BeginViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/5.
//

import UIKit

class BeginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var controllerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var player : PlayerInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.insertSubview(produceBackground(view.frame), at: 0)
        nameTextField.delegate = self
        }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    //unwind segue from ResultViewController
    @IBAction func reStart(segue: UIStoryboardSegue){
        nameTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "changetoSubject"){
            if let controller = segue.destination as? SubjectViewController{
                controller.player = self.player
            }
        }
    }
    
    @IBAction func startGame(_ sender: Any) {
     
        if let text = nameTextField.text,
           !text.isEmpty{
            player = PlayerInfo(name: text, score: 0)
            performSegue(withIdentifier: "changetoSubject", sender: nil)
        }
        else{
            let alertController = UIAlertController(title: "尚未輸入名字", message: "請輸入名字", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            }
        }
    
    @IBAction func showScoreRanking(_ sender: Any) {
        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "\(ScoreViewController.self)") else { return }
        present(controller, animated: true, completion: nil)
    }
    
}


