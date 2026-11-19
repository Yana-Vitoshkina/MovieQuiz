//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Yana Vitoshkina on 16.11.2026.
//

import Foundation

struct AlertModel {
    let title: String        // текст заголовка алерта
    let message: String      // текст сообщения алерта
    let buttonText: String   // текст для кнопки алерта
    let completion: () -> Void  // замыкание без параметров для действия по кнопке
}
