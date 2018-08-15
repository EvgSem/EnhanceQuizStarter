//
//  Question.swift
//  EnhanceQuizStarter
//
//  Created by Ievgeniia Bondini on 8/14/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
struct Option {
    var name: String
}

struct Question {
    
    var questionTitle: String
    var options: [Option] = [Option]()
    var answer: Int
}
