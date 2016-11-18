//
//  KanaGuessController.swift
//  KanaProject
//
//  Created by Eugene Chechkov on 2/20/15.
//  Copyright (c) 2015 Eugene Chechkov. All rights reserved.
//

import UIKit

class KanaGuessController: UIViewController {

    enum AnswerButtonType: Int{
        case button1 = 0, button2 = 1, button3 = 2 , button4 = 3
    }
    
    let backgroundImagesCount = 1
    let questionsCount = 20
    
    @IBOutlet weak var hieroglyphLbl: UILabel!
    @IBOutlet weak var answer1Btn: UIButton!
    @IBOutlet weak var answer2Btn: UIButton!
    @IBOutlet weak var answer3Btn: UIButton!
    @IBOutlet weak var answer4Btn: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var rightAnswersCount: UILabel!
    @IBOutlet weak var wrongAnswersCount: UILabel!
    
    
    var hieros:[Hieroglyph]?
    var trueIndex:Int?
    var trueString:String?
    var wrongAnswers = 0
    var rightAnswers = 0
    var questionNumber = 0
    
    var color: UIColor?
    
    var kanaType: KanaType? {
        didSet {
            if(self.isViewLoaded){
                regenerateHierogliph()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.hieroglyphLbl.adjustsFontSizeToFitWidth = true
   
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            self.rightAnswersCount.font = UIFont(name: "Zapfino", size: 45.0)
            self.wrongAnswersCount.font = UIFont(name: "Zapfino", size: 45.0)
        } else {
            self.rightAnswersCount.font = UIFont(name: "Zapfino", size: 22.0)
            self.wrongAnswersCount.font = UIFont(name: "Zapfino", size: 22.0)
        }
        
        self.rightAnswersCount.text = "\(rightAnswers)"
        self.wrongAnswersCount.text = "\(wrongAnswers)"
        
        loadHieroglyphsFromFile()
        regenerateHierogliph()
        
        self.title = "\(questionNumber+1)\\\(questionsCount)"
        
        color = self.hieroglyphLbl.textColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func loadHieroglyphsFromFile(){
        if kanaType != nil {
             hieros = KanaService.loadHierosFromFile(kanaType!)
        }
    }
    
    func regenerateHierogliph()
    {
        self.changeBackgroundRandom()
        if  kanaType != nil && hieros != nil {
        
            let generatedNumbersArray =  KanaService.generateRandoms(4, upperBound: hieros!.count)
            trueIndex = KanaService.generateRandomNumberWithUpperBound(4)
    
            let trueNumber =  generatedNumbersArray[trueIndex!]
            let hiero = hieros![trueNumber]
            
            self.hieroglyphLbl.text = "\(UnicodeScalar(hiero.code))"
            
            self.answer1Btn.setTitle(hieros?[generatedNumbersArray[0]].name, for: UIControlState())
            self.answer2Btn.setTitle(hieros?[generatedNumbersArray[1]].name, for: UIControlState())
            self.answer3Btn.setTitle(hieros?[generatedNumbersArray[2]].name, for: UIControlState())
            self.answer4Btn.setTitle(hieros?[generatedNumbersArray[3]].name, for: UIControlState())
        }
    }
    
    @IBAction func giveAnswer(_ sender: AnyObject) {
        
        var btnType: AnswerButtonType?
        
        switch(sender){
            case self.answer1Btn as UIButton:
                btnType = AnswerButtonType.button1
            case self.answer2Btn as UIButton:
                btnType = AnswerButtonType.button2
            case self.answer3Btn as UIButton:
                btnType = AnswerButtonType.button3
            case self.answer4Btn as UIButton:
                btnType = AnswerButtonType.button4
            default:
                break;
        }
        if btnType != nil {
            giveAnswer(btnType, sender: sender as! UIButton)
        }
    }

    func giveAnswer(_ button: AnswerButtonType?, sender: UIButton){
        
        questionNumber += 1

        if trueIndex == button!.rawValue {
            rightAnswers += 1
            rightAnswersCount.text = "\(rightAnswers)"
        } else {
            wrongAnswers += 1
            wrongAnswersCount.text = "\(wrongAnswers)"
        }
        
        if questionNumber == questionsCount {
            self.finishTest()
        } else {
            self.title = "\(questionNumber+1)\\\(questionsCount)"
            self.regenerateHierogliph()
        }
    }
    
    func finishTest(){
        let percentage = Int((rightAnswers * 100) / questionsCount)
        
        var messageText = "\(percentage)% of right answers. "
        
        switch percentage {
        case 0 ..< 25:
            messageText = messageText + "You can do it better. Please try again."
        case 25 ..< 50:
            messageText = messageText + "Not bad. You should practice to improve you skills."
        case 50 ..< 75:
            messageText = messageText + "Good. Would you like to get to the next level?"
        case 75 ..< 100:
            messageText = messageText + "Very good. Just one step to the master level"
        case 100:
            messageText = messageText + "You are as good as sensei. )"
        default:
            messageText = messageText + "You can do it better. Please try again."
        }
        
        let alertView = UIAlertController(title: nil, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: {[unowned self](UIAlertAction) in
            
            self.questionNumber = 0
            self.rightAnswers = 0
            self.wrongAnswers = 0
            self.rightAnswersCount.text = "\(self.rightAnswers)"
            self.wrongAnswersCount.text = "\(self.wrongAnswers)"
            self.title = "\(self.questionNumber+1)\\\(self.questionsCount)"
            self.regenerateHierogliph()
            
        }))
        self.present(alertView, animated: true, completion: nil)
    }

    func changeBackgroundRandom(){
        let randomNumber = 1 + Int(arc4random_uniform(UInt32(backgroundImagesCount)));
        let image = UIImage(named: "Background\(randomNumber)")
        self.backgroundImage.image = image
    }
}
