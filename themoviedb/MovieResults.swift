//
//  MovieModel.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 5/31/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit
import Gloss

struct MovieResults: Decodable {
    
    let page: Int
    let movies: [Movie]
    
    // MARK: - Deserialization
    
    public init?(json: JSON) {
     
        guard let page: Int = "page" <~~ json else {
            return nil
        }
        guard let movies: [Movie] = "results" <~~ json else {
            return nil
        }
        
        self.page = page
        self.movies = movies
      
    }
    
}
