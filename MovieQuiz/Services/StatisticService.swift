//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Yana Vitoshkina on 18.11.2026.
//
import Foundation

final class StatisticService: StatisticServiceProtocol {
    private let storage: UserDefaults = .standard
    
    func store(correct count: Int, total amount: Int) {
        gamesCount += 1
        
        //накапливаем общую статистику по всем играм
        totalCorrectAnswers += count
        totalQuestionsAsked += amount
        
        //обновляем рекорд, если текущая игра лучше
        let currentBest = bestGame
        if count > currentBest.correct {
        bestGame = GameResult(correct: count, total: amount, date: Date())
        }
    }
    
    private enum Keys: String {
        case gamesCount          // Для счётчика сыгранных игр
        case bestGameCorrect     // Для количества правильных ответов в лучшей игре
        case bestGameTotal       // Для общего количества вопросов в лучшей игре
        case bestGameDate        // Для даты лучшей игры
        case totalCorrectAnswers // Для общего количества правильных ответов за все игры
        case totalQuestionsAsked // Для общего количества вопросов, заданных за все игры
    }
    
    // счётчик игр, хранится между запусками приложения в UserDefaults
    var gamesCount: Int {
        get {
            // читаем значение из UserDefaults, если его нет — возвращаем 0
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            // записываем новое значение в UserDefaults
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            // читаем значения полей из UserDefaults
            let correct = storage.integer(forKey: Keys.bestGameCorrect.rawValue)
            let total = storage.integer(forKey: Keys.bestGameTotal.rawValue)
            
            let date = (storage.object(forKey: Keys.bestGameDate.rawValue) as? Date) ?? Date()
            
            // создаём GameResult из полученных значений
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            // записываем каждое поле из newValue в UserDefaults
            storage.set(newValue.correct, forKey: Keys.bestGameCorrect.rawValue)
            storage.set(newValue.total, forKey: Keys.bestGameTotal.rawValue)
            storage.set(newValue.date, forKey: Keys.bestGameDate.rawValue)
        }
    }
    
    // общее число правильных ответов за все игры
    var totalCorrectAnswers: Int {
        get {
            storage.integer(forKey: Keys.totalCorrectAnswers.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalCorrectAnswers.rawValue)
        }
    }
    
    // общее число заданных вопросов за все игры
    var totalQuestionsAsked: Int {
        get {
            storage.integer(forKey: Keys.totalQuestionsAsked.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.totalQuestionsAsked.rawValue)
        }
    }
    
    // средняя точность ответов за все игры, в процентах
    var totalAccuracy: Double {
        // если ещё не было задано ни одного вопроса — точность считаем нулевой
        guard totalQuestionsAsked > 0 else { return 0 }
        
        // отношение общего числа правильных ответов ко всем заданным вопросам,приведённое к процентам
        return Double(totalCorrectAnswers) / Double(totalQuestionsAsked) * 100
    }
}
