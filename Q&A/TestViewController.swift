//
//  TestViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/5.
//

import UIKit

class TestViewController: UIViewController {
    
    var player: PlayerInfo?
    var testSubject : SubjectInfo?
    let idx = 0
    var curIdx = 0
    var timer : Timer?
    var currQuestion = 1
    var remainingTime = 0
    var isFinalQusetion = false

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var currentQuestionLabel: UILabel!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet var selectButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(produceBackground(view.frame), at: 0)
        
        updateUI()
        startTimer()
        
       
    }
    
    func updateUI(){
        guard let player = player, let testSubject = testSubject, let questions = testSubject.questions else {
            return
        }

        subjectLabel.text = testSubject.selectSubject.rawValue
        scoreLabel.text = player.score.description
     
        remainingTime = 20
        countdownLabel.text = remainingTime.description
       // countdownLabel.text = "20"
        currentQuestionLabel.text = "\(currQuestion)/\(testSubject.questionCount)"
        questionTextView.text = questions[curIdx].question
        
        //set button title
        for idx in 0..<questions[curIdx].options.count{
            selectButtons[idx].setTitle(questions[curIdx].options[idx].description, for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        stopTimer()
        
    }
    
    @IBAction func confirmAnswer(_ sender: UIButton){
        
        guard let testSubject = testSubject, let _ = player else {
            return
        }

        
        currQuestion += 1
        
        let answer = testSubject.questions![curIdx].answer
        
        if sender.currentTitle?.description == answer{
            self.player!.score += 10
            curIdx+=1
            nextQuestion()
            
        }
        else{
            stopTimer()
            let alertController = UIAlertController(title: "答錯了", message: "正確答案是 \(testSubject.questions![curIdx].answer)", preferredStyle: .alert)
            
            let alertButton = UIAlertAction(title: "確認", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                self.nextQuestion()
                self.startTimer()
            })
                
            alertController.addAction(alertButton)
            
            self.present(alertController, animated: true, completion: nil)
            curIdx+=1
        }
        
       
        
    }
    
    func nextQuestion(){
        guard let testSubject = testSubject else {
            return
        }

        if curIdx == testSubject.questionCount{
            if isFinalQusetion {
                performSegue(withIdentifier: "changetoResult", sender: nil)
            }
            else {
                performSegue(withIdentifier: "backtoSubject", sender: nil)
               
            }
            return
        }
        
        updateUI()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changetoResult"{
            if let controller = segue.destination as? ResultViewController{
                controller.player = player
            }
        }
    }
    
    
    func startTimer(){
        
        guard timer == nil else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
  
    }
    
    func stopTimer(){
        if let _ = timer{
            timer!.invalidate()
            timer = nil
        }
    }
    
    @objc func countdown(){
        
        guard let testSubject = testSubject, let questions = testSubject.questions else {
            return
        }

       
        if remainingTime > 0{
            remainingTime -= 1
            countdownLabel.text = remainingTime.description
        }
        //over time and skip this question
        else{
            curIdx += 1
            currQuestion += 1
            
            if curIdx < testSubject.questionCount{
                
                currentQuestionLabel.text = "\(curIdx + 1)/\(testSubject.questionCount)"
                questionTextView.text = questions[curIdx].question
               
                
                //set option
                for idx in 0..<questions[curIdx].options.count
                {
                    selectButtons[idx].setTitle(questions[curIdx].options[idx], for: .normal)
                }
                
            }
            //finish all question
            else{
             
                stopTimer()
                if isFinalQusetion {
                    performSegue(withIdentifier: "changetoResult", sender: nil)
                }
                else {
                    performSegue(withIdentifier: "backtoSubject", sender: nil)
                }
            }
            
            //due to overtime so reset the clock
            remainingTime = 20
            countdownLabel.text = remainingTime.description
        }
    }
    

    
}
