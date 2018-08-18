import Foundation

struct Option {
    var name: String
}

struct Question {
    var questionTitle: String
    var options: [Option] = [Option]()
    var answer: Int
}
