//
//  Errors.swift
//  WorldNewsApp
//
//  Created by Alexander Bokhulenkov on 25.10.2024.
//

import Foundation

enum RequestError: Error, LocalizedError {
    case badURL
    case apiKeyDisabled
    case apiKeyExhausted
    case apiKeyInvalid
    case apiKeyMissing
    case parameterInvalid
    case parametersMissing
    case rateLimited
    case sourcesTooMany
    case sourceDoesNotExist
    case unexpectedError
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Ошибка в URL адресе"
        case .apiKeyDisabled:
            return "Ваш ключ API отключен"
        case .apiKeyExhausted:
            return "Для вашего ключа API больше нет доступных запросов"
        case .apiKeyInvalid:
            return "Ваш ключ API введен неправильно. Дважды проверьте это и попробуйте еще раз"
        case .apiKeyMissing:
            return "Ваш ключ API отсутствует в запросе. Добавьте его к запросу"
        case .parameterInvalid:
            return "Вы включили в свой запрос параметр, который в настоящее время не поддерживается"
        case .parametersMissing:
            return "В запросе отсутствуют обязательные параметры, и его невозможно выполнить"
        case .rateLimited:
            return "Вы исчерпали лимит запросов. Попробуйте позже"
        case .sourcesTooMany:
            return "Вы запросили слишком много источников в одном запросе. Попробуйте разделить запрос на два меньших запроса"
        case .sourceDoesNotExist:
            return "Вы запросили источник, которого не существует"
        case .unexpectedError:
            return "Непредвиденная ошибка. Повторите запрос позже"
        }
    }
}
