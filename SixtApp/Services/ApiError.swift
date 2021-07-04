//
//  ApiError.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation

//API Client Errors
enum ApiError: Error {
    case cannotInstantiateUrl(String)
    case httpError(Int, String)
    case serializationError(Error)
    case error(Error)
}
