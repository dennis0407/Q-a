//
//  TestViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/5.
//

import UIKit

class TestViewController: UIViewController {
    
    var player: PlayerInfo!
    var testSubject : SubjectInfo!
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
        
        if  let player = player,
            let testSubject = testSubject,
            let questions = testSubject.questions{
            subjectLabel.text = testSubject.selectSubject.rawValue
            scoreLabel.text = player.score.description
         
            remainingTime = 20
            countdownLabel.text = remainingTime.description
            countdownLabel.text = "20"
            currentQuestionLabel.text = "\(currQuestion)/\(testSubject.questionCount)"
            questionTextView.text = questions[curIdx].question
            
            //set button title
            for idx in 0..<questions[curIdx].options.count{
                selectButtons[idx].setTitle(questions[curIdx].options[idx].description, for: .normal)
                
                startTimer()
            }
        }
        
    
       
    }
    
//    init(coder: NSCoder, player: PlayerInfo, testSubject: SubjectInfo){
//        super.init(coder: coder)!
//        self.player = player
//        self.testSubject = testSubject
//    }
    
    init(coder: NSCoder, player: PlayerInfo, testSubject: SubjectInfo, isFinalQusetion: Bool){
        super.init(coder: coder)!
        self.player = player
        self.testSubject = testSubject
        self.isFinalQusetion = isFinalQusetion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        stopTimer()
        
    }
    
    @IBAction func confirmAnswer(_ sender: UIButton){
        
        currQuestion += 1
        
        let answer = testSubject.questions![curIdx].answer
        
        if sender.currentTitle?.description == answer{
            player.score += 10
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
        
        if curIdx == testSubject.questionCount{
            if isFinalQusetion {
                performSegue(withIdentifier: "changetoResult", sender: nil)
            }
            else {
                performSegue(withIdentifier: "backtoSubject", sender: nil)
            }
            return
        }
        remainingTime = 20
        countdownLabel.text = remainingTime.description
        currentQuestionLabel.text = "\(currQuestion)/\(testSubject.questionCount)"
        
        subjectLabel.text = testSubject.selectSubject.rawValue
        scoreLabel.text = player.score.description
     
        questionTextView.text = testSubject.questions![curIdx].question
        
        for idx in 0..<testSubject.questions![curIdx].options.count{
            selectButtons[idx].setTitle(testSubject.questions![curIdx].options[idx].description, for: .normal)
        }
        
        
    }

    @IBSegueAction func backtoSubjectSegue(_ coder: NSCoder) -> SubjectViewController? {
        SubjectViewController(coder: coder, player: player, beginSubject: testSubject)
    }
    
    
    @IBSegueAction func changetoResultSegue(_ coder: NSCoder) -> ResultViewController? {
         ResultViewController(coder: coder, player: player)
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
