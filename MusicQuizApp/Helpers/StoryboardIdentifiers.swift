//
//  SegueIdentifiers.swift
//  MusicQuizApp
//
//  Created by John Tudor on 21/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation

enum SegueIdentifiers: String {
    case StartMenu = "mainmenu"
    case QuizScreen = "loadQuestions"
}

enum CollectionViewIdentifiers: String {
    case CategorysHeader = "CategoryHeader"
    case CollectionViewCell = "ShareCell"
}

enum NewStoryboardIdentifiers: String {
    case QuizCompleteView = "QuizCompletedViewController"
    case NextQuizView = "QuestionViewController"
}
