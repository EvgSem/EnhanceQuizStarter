import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 10
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var counter = 0
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    var questionnaire = Questionnaire()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionnaire.generateQuestions()
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

        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionnaire.questions.count)
        let questionDictionary = questionnaire.questions[indexOfSelectedQuestion]
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
        
        loadNextRound(delay: 5)
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
                if self.questionnaire.questions.count > 0 {
                    self.questionnaire.questions.remove(at: self.indexOfSelectedQuestion)
                }
                
                self.nextRound()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        let selectedQuestionDict = questionnaire.questions[indexOfSelectedQuestion]
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
        questionnaire.generateQuestions()
        nextRound()
    }

}
