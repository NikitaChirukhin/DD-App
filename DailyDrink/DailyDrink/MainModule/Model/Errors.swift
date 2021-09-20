//
//  Errors.swift
//  DailyDrink
//
//  Created by Никита Чирухин on 20.09.2021.
//

import Foundation

enum CustomError: Error {
    case unknownError
    case connectionError
    case invalidData
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsuppotedURL
 }

