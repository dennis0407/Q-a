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
        
        
        //check button status
        if let beginSubject = beginSubject{
            for idx in 0..<beginSubject.finishSubject.count{
                if beginSubject.finishSubject[idx] == true{
                    subjectButtons[idx].isEnabled = false
                }
            }
        }

    }
    
    init(coder: NSCoder, player: PlayerInfo){
        super.init(coder: coder)!
        self.player = player
    }
    
    init(coder: NSCoder, player: PlayerInfo, beginSubject: SubjectInfo){
        super.init(coder: coder)!
        self.player = player
        self.beginSubject = beginSubject
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    @IBSegueAction func changetoTestSegue(_ coder: NSCoder) -> TestViewController? {
        TestViewController(coder: coder, player: player!, testSubject: beginSubject!, isFinalQusetion: isFinalQuestion)
    }
    
    @IBAction func startQuiz(_ sender: UIButton) {
       
        var unknownButton = false
        var selectQuestion: [Question]?
        
        if beginSubject == nil{
            beginSubject = SubjectInfo(selectSubject: .geography, finishSubject: [false, false, false, false, false],questions: nil, questionCount: 2)
        }
        
        switch sender.tag {
            case 0:
                //geography subject
                geographyQuestions.shuffle()
                selectQuestion = [geographyQuestions[0], geographyQuestions[1]]
                beginSubject!.selectSubject = .geography
                beginSubject!.finishSubject[0] = true
            case 1:
                //histroy subject
                historyQuestions.shuffle()
                selectQuestion = [historyQuestions[0], historyQuestions[1]]
                beginSubject!.selectSubject = .history
                beginSubject!.finishSubject[1] = true
            case 2:
                //science subject
                scienceQuestions.shuffle()
                selectQuestion = [scienceQuestions[0], scienceQuestions[1]]
                beginSubject!.selectSubject = .science
                beginSubject!.finishSubject[2] = true
                
            case 3:
                //civics subject
                civicsQuestions.shuffle()
                selectQuestion = [civicsQuestions[0], civicsQuestions[1]]
                beginSubject!.selectSubject = .civics
                beginSubject!.finishSubject[3] = true
                
            case 4:
                //helath subject
                healthQuestions.shuffle()
                selectQuestion = [healthQuestions[0], healthQuestions[1]]
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
    
}
