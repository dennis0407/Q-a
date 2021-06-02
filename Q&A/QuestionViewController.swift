//
//  QuestionViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/5/30.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var curIdx = 0
    var curScore = 0
    var timer : Timer?
    var remainingTime = 0
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet var controllerView: UIView!
    @IBOutlet weak var countdownTimerLabel: UILabel!
    
    @IBOutlet weak var currentQusetionLabel: UILabel!
    @IBOutlet var selectButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        startTimer()
        
        let backgroundImage = UIImage(named: "background")
        
        let ImageView = UIImageView(image: backgroundImage)
        ImageView.frame = controllerView.frame
        view.insertSubview(ImageView, at: 0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        stopTimer()
        
    }
    
    func startTimer(){
        
        guard timer == nil else {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
  
    }
    
    func stopTimer(){
        if timer != nil{
            timer!.invalidate()
            timer = nil
        }
    }
    
    @objc func countdown(){
        
       
        if remainingTime > 0{
            remainingTime -= 1
            countdownTimerLabel.text = remainingTime.description
        }
        //over time and skip this question
        else{
            curIdx += 1
            
            
            if curIdx < 10{
                
                currentQusetionLabel.text = "\(curIdx + 1)/10"
                
                questionTextView.text = questions[curIdx].question
                
                questions[curIdx].options.shuffle()
                
                //set option
                for idx in 0..<questions[curIdx].options.count
                {
                    selectButtons[idx].setTitle(questions[curIdx].options[idx], for: .normal)
                }
                
            }
            //finish all question
            else{
             
                stopTimer()
               
                let alertController = UIAlertController(title: "結束", message: "總共得\(curScore)分", preferredStyle: .alert)
                
                let restartButton = UIAlertAction(title: "重新一次", style: .default, handler: {
                    (action: UIAlertAction!) -> Void in
                    self.startGame()
                    self.startTimer()
                    
                })
                
                alertController.addAction(restartButton)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            //due to overtime so reset the clock
            remainingTime = 20
            countdownTimerLabel.text = remainingTime.description
        }
    }
    
    
    func startGame(){
        
        remainingTime = 20
        countdownTimerLabel.text = remainingTime.description
        
        curIdx = 0
        curScore = 0
        
        scoreLabel.text  = "0"
        currentQusetionLabel.text = "\(curIdx + 1)/10"
        
        questions.shuffle();
        
        questionTextView.text = questions[curIdx].question
        
        questions[curIdx].options.shuffle()
        
        for idx in 0..<questions[curIdx].options.count
        {
            selectButtons[idx].setTitle(questions[curIdx].options[idx], for: .normal)
        }
        
        
        
    }
    
    @IBAction func wirteAnswer(_ sender: UIButton) {
        
        if sender.currentTitle == questions[curIdx].answer
        {
            curScore += 10
            scoreLabel.text = curScore.description
            nextQuestion()
        }
        else {
            
            stopTimer()
            
            let alertController = UIAlertController(title: "答錯了", message: "正確答案是 \(questions[curIdx].answer)", preferredStyle: .alert)
            
            let alertButton = UIAlertAction(title: "確認", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                self.nextQuestion()
                self.startTimer()
            })
                
            alertController.addAction(alertButton)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
       
        
    }
    
    func nextQuestion(){
   
   
        curIdx += 1
        
        remainingTime = 20
        countdownTimerLabel.text = remainingTime.description
        
        if curIdx != 10{
            
            currentQusetionLabel.text = "\(curIdx + 1)/10"
            
            questionTextView.text = questions[curIdx].question
            
            questions[curIdx].options.shuffle()
            
            for idx in 0..<questions[curIdx].options.count
            {
                selectButtons[idx].setTitle(questions[curIdx].options[idx], for: .normal)
            }
            
        }
        else{
         
            stopTimer()
           
            let alertController = UIAlertController(title: "結束", message: "總共得\(curScore)分", preferredStyle: .alert)
            
            let restartButton = UIAlertAction(title: "重新一次", style: .default, handler: {
                (action: UIAlertAction!) -> Void in
                self.startGame()
                self.startTimer()
                
            })
            
            alertController.addAction(restartButton)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    
        
   
    }
  
}
