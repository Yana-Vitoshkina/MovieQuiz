//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Yana Vitoshkina on 16.11.2026.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void  
}
