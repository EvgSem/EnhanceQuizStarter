import Foundation

class Questionnaire {
    
    var questions: [Question] = [Question]()
    
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
        
        questions = [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10]
    }

}
