//
//  History.swift
//  Project5
//
//  Created by user197801 on 6/4/21.
//

import UIKit

class History: NSObject, Codable {
    init(question: String, answers: [String]) {
        self.question = question
        self.answers = answers
    }
    var question: String
    var answers: [String]
}
