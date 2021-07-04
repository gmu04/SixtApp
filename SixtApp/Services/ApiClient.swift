//
//  ApiClient.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 4.07.2021.
//

import Foundation


protocol ApiClient{

    func fetch(path:String, completion: @escaping (Result<Any, ApiError>)->Void)

}
