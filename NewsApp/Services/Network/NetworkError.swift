//
//  NetworkError.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case serverError(description: String)
    case dataLoad
    case unknown
    case noConnection
    case unauthorized
    case locked
    
    var description: String {
        switch self {
        case .serverError(let description):
            return description
        case .dataLoad:
            return "Возникла ошибка при загрузке данных. Приносим свои извинения за доставленные неудобства."
        case .unknown:
            return "Возникла непредвиденная ошибка. Приносим свои извинения за доставленные неудобства."
        case .noConnection:
            return "Отсутствует интернет соединение"
        case .unauthorized:
            return "Неверный логин или пароль"
        case .locked:
            return "Пользователь заблокирован"
        }
    }
}
