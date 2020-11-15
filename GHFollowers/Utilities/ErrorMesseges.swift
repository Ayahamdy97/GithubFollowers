//
//  ErrorMesseges.swift
//  GHFollowers
//
//  Created by Aya on 10/11/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import Foundation
enum GFError : String , Error{
    
    case invalidUsername  = "this username created invalid request, please try again"
    case unableToComplete = "unable to complete your request. please check you enternet connection"
    case invalidResponse  = "invalid response from the serve. please try again"
    case invalidData      = "data received from the server was invalid. please try again"
    case unableToFavorite = "There was an error faavoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user. You must REALLy like them!"
}

