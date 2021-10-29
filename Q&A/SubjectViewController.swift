//
//  SubjectViewController.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/5.
//

import UIKit

class SubjectViewController: UIViewController {

    var beginSubject: SubjectInfo?
    var player : PlayerInfo?
    var isFinalQuestion = false

    @IBOutlet var subjectButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(produceBackground(view.frame), at: 0)
    }
    
    @IBAction func startQuiz(_ sender: UIButton) {
       
        var unknownButton = false
        var selectQuestion: [Question]?
        
        //Initialize beginSubject
        if beginSubject == nil{
            beginSubject = SubjectInfo(selectSubject: .geography, finishSubject: [false, false, false, false, false], questions: nil, questionCount: 5)
        }
        
        switch sender.tag {
            case 0:
                //geography subject
                geographyQuestions.shuffle()
                selectQuestion = [geographyQuestions[0], geographyQuestions[1], geographyQuestions[2], geographyQuestions[3], geographyQuestions[4]]
                beginSubject!.selectSubject = .geography
                beginSubject!.finishSubject[0] = true
            case 1:
                //histroy subject
                historyQuestions.shuffle()
                selectQuestion = [historyQuestions[0], historyQuestions[1], historyQuestions[2], historyQuestions[3], historyQuestions[4]]
                beginSubject!.selectSubject = .history
                beginSubject!.finishSubject[1] = true
            case 2:
                //science subject
                scienceQuestions.shuffle()
                selectQuestion = [scienceQuestions[0], scienceQuestions[1], scienceQuestions[2], scienceQuestions[3], scienceQuestions[4]]
                beginSubject!.selectSubject = .science
                beginSubject!.finishSubject[2] = true
                
            case 3:
                //civics subject
                civicsQuestions.shuffle()
                selectQuestion = [civicsQuestions[0], civicsQuestions[1], civicsQuestions[2], civicsQuestions[3], civicsQuestions[4]]
                beginSubject!.selectSubject = .civics
                beginSubject!.finishSubject[3] = true
                
            case 4:
                //helath subject
                healthQuestions.shuffle()
                selectQuestion = [healthQuestions[0], healthQuestions[1], healthQuestions[2], healthQuestions[3], healthQuestions[4]]
                beginSubject!.selectSubject = .health
                beginSubject!.finishSubject[4] = true
              default:
                unknownButton = true
        }
        
       //  final question 
        if !beginSubject!.finishSubject.contains(false){
            isFinalQuestion = true
        }

        
        if !unknownButton{
            beginSubject!.questions = selectQuestion
            for idx in 0..<beginSubject!.questionCount{
                //shuffle select options
                beginSubject?.questions![idx].options.shuffle()
            }
            performSegue(withIdentifier: "changetoTest", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changetoTest" {
            if let controller = segue.destination as? TestViewController{
                controller.testSubject = self.beginSubject
                controller.player = self.player
                controller.isFinalQusetion = self.isFinalQuestion
            }
        }
        else if segue.identifier == "skiptoResult"{
            if let controller = segue.destination as? ResultViewController{
                controller.player = player
            }
        }
    }
    
    //undwind segue from testViewController
    @IBAction func backToSubjectViewController(segue: UIStoryboardSegue){
        guard let controller = segue.source as? TestViewController else { return }
        player = controller.player
        beginSubject = controller.testSubject
        
        if let beginSubject = beginSubject{
            for idx in 0..<beginSubject.finishSubject.count{
                
                if beginSubject.finishSubject[idx] == true{
                    searchTagButton(idx)?.isEnabled = false
                }
            }
        }
    }
    
    
    @IBAction func skipQuestion(_ sender: Any) {
        performSegue(withIdentifier: "skiptoResult", sender: nil)
    }
    
    func searchTagButton(_ tag: Int)->UIButton?{
        for button in subjectButtons{
            if button.tag == tag{
                return button
            }
        }
        return nil
    }
    
}

