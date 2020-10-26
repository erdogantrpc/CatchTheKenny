//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Erdogan Turpcu on 25.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScoreLabel.text = "Score: \(score)"
        
        //Check Highscore
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "Highscore \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore \(highScore)"
        }
        //Images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(incScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(incScore))

        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        //Timer
        
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideAndShowKenny), userInfo: nil, repeats: true)
        
        hideAndShowKenny()
    }
    
    @objc func hideAndShowKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }

    
    @objc func incScore(){
        score += 1
        ScoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highScoreLabel.text = "Highscore \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay
                self.score = 0
                self.ScoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideAndShowKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

}

