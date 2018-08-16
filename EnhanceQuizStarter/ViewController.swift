//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 10
    var questionsAsked = -1
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var counter = 0
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    var trivia = [Question]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        generateQuestions()
        loadSounds()
        playGameStartSound()
        displayQuestion()
    }
    
    
    
    // MARK: - Helpers
    
    func loadSounds() {
        let gameSoundPath = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let gameSoundSoundUrl = URL(fileURLWithPath: gameSoundPath!)
        AudioServicesCreateSystemSoundID(gameSoundSoundUrl as CFURL, &gameSound)
        
        let correctAnswerPath = Bundle.main.path(forResource: "CorrectAnswer", ofType: "wav")
        let correctAnswerSoundUrl = URL(fileURLWithPath: correctAnswerPath!)
        AudioServicesCreateSystemSoundID(correctAnswerSoundUrl as CFURL, &correctAnswerSound)
        
        let wrongAnswerPath = Bundle.main.path(forResource: "WrongAnswer", ofType: "wav")
        let wrongAnswerSoundUrl = URL(fileURLWithPath: wrongAnswerPath!)
        AudioServicesCreateSystemSoundID(wrongAnswerSoundUrl as CFURL, &wrongAnswerSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    func playWrongSoundSound() {
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
    
    func displayQuestion() {
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        let questionDictionary = trivia[indexOfSelectedQuestion]
        questionField.text = questionDictionary.questionTitle
        
        var buttons = [option1Button, option2Button, option3Button, option4Button]
        
        for i in 0..<questionDictionary.options.count {
            
            buttons[i]?.setTitle(questionDictionary.options[i].name, for: .normal)
            buttons[i]?.isHidden = false
        }
        
        for i in questionDictionary.options.count..<buttons.count{
            buttons[i]?.isHidden = true
        }
        
        playAgainButton.isHidden = true
        questionsAsked += 1
        loadNextRound(delay: 15)
    }
    
    func displayScore() {
        // Hide the answer uttons
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        
        let localQuestionsAsked = questionsAsked
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            if localQuestionsAsked == self.questionsAsked {
                self.nextRound()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        let selectedQuestionDict = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.options[selectedQuestionDict.answer].name
        
        let usersAnswer = (sender as UIButton).titleLabel?.text
        
        if usersAnswer == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            playCorrectAnswerSound()
        } else {
            questionField.text = "Sorry, wrong answer! \n Correct answer is \(correctAnswer)."
            playWrongSoundSound()
        }
        trivia.remove(at: indexOfSelectedQuestion)
        
        loadNextRound(delay: 2)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        generateQuestions()
        nextRound()
    }
    
    
    func generateQuestions(){
        
        let q1 = Question(questionTitle: "This was the only US President to serve more than two consecutive terms.",
                          options: [Option(name: "George Washington"),
                                    Option(name: "Franklin D. Roosevelt"),
                                  //  Option(name: "Woodrow Wilson"),
                                    Option(name: "Andrew Jackson")],
                          answer: 1)
        let q2 = Question(questionTitle: "Which of the following countries has the most residents?",
                          options: [Option(name: "Nigeria"),
                                   // Option(name: "Russia"),
                                    Option(name: "Iran"),
                                    Option(name: "Vietnam")],
                          answer: 0)
        let q3 = Question(questionTitle: "In what year was the United Nations founded?",
                          options: [Option(name: "1918"),
                                    Option(name: "1919"),
                                    Option(name: "1945"),
                                    Option(name: "1954")],
                          answer: 2)
        let q4 = Question(questionTitle: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                          options: [Option(name: "Paris"),
                                    Option(name: "Washington D.C."),
                                    Option(name: "New York City"),
                                    Option(name: "Boston")],
                          answer: 2)
        
        let q5 = Question(questionTitle: "Which nation produces the most oil?",
                          options: [Option(name: "Paris"),
                                    Option(name: "Washington D.C."),
                                    Option(name: "New York City"),
                                    Option(name: "Boston")],
                          answer: 2)
        let q6 = Question(questionTitle: "Which country has most recently won consecutive World Cups in Soccer?",
                          options: [Option(name: "Italy"),
                                    Option(name: "Brazil"),
                                    Option(name: "Argetina"),
                                    Option(name: "Spain")],
                          answer: 1)
        let q7 = Question(questionTitle: "Which of the following rivers is longest?",
                          options: [Option(name: "Yangtze"),
                                    Option(name: "Mississippi"),
                                    Option(name: "Congo"),
                                    Option(name: "Mekong")],
                          answer: 1)
        let q8 = Question(questionTitle: "Which city is the oldest?",
                          options: [Option(name: "Mexico City"),
                                    Option(name: "Cape Town"),
                                    Option(name: "San Juan"),
                                    Option(name: "Sydney")],
                          answer: 0)
        let q9 = Question(questionTitle: "Which country was the first to allow women to vote in national elections?",
                          options: [Option(name: "Poland"),
                                    Option(name: "United States"),
                                    Option(name: "Sweden"),
                                    Option(name: "Senegal")],
                          answer: 0)
        let q10 = Question(questionTitle: "Which of these countries won the most medals in the 2012 Summer Games?",
                           options: [Option(name: "France"),
                                     Option(name: "Germany"),
                                     Option(name: "Japan"),
                                     Option(name: "Great Britian")],
                           answer: 3)
        
        trivia = [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10]
    }

}

