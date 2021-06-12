//
//  PlayerInfo.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/5.
//

import Foundation

enum subject: String {
    case history = "歷史"
    case geography = "地理"
    case science = "科學"
    case civics = "公民"
    case health = "健康"
}

struct PlayerInfo {
    let name: String
    var score: Int
}


struct SubjectInfo {
    var selectSubject: subject
    var finishSubject: [Bool]
    var questions: [Question]?
    var questionCount: Int
}

