//
//  ViewController.swift
//  QuizyApp
//
//  Created by Kostadin Samardzhiev on 22.12.21.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            thirdButton.isHidden = false
            quizBrain.changeQuizType(true)
            updateUI()
        } else {
            thirdButton.isHidden = true
            quizBrain.changeQuizType(false)
            updateUI()
        }
    }
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = (sender.titleLabel?.text!)!
        
        if quizBrain.checkAnswer(userAnswer) {
            print("Right!")
            sender.backgroundColor = UIColor.init(hex: "#94D0CCFF")
        } else {
            print("Wrong!")
            sender.backgroundColor = UIColor.init(hex: "#F29191FF")
        }
        
        quizBrain.nextQuestion()

        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        thirdButton.backgroundColor = UIColor.clear
        
        if quizBrain.isMultiAnswerQuizTypeSelected() {
            let answers = quizBrain.getPossibleAnswers()
            trueButton.setTitle(answers[0], for: .normal)
            falseButton.setTitle(answers[1], for: .normal)
            thirdButton.setTitle(answers[2], for: .normal)
        } else {
            trueButton.setTitle("True", for: .normal)
            falseButton.setTitle("False", for: .normal)
        }
        
    }
    
}

