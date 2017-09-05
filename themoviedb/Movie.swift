//
//  Movie.swift
//  themoviedb
//
//  Created by Yasser Mabrouk on 6/1/17.
//  Copyright © 2017 Yasser Mabrouk. All rights reserved.
//

import UIKit
import Gloss

struct Movie: Decodable {

    var id: Int?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var popularity: Double?
 
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.original_title = "original_title" <~~ json
        self.overview = "overview" <~~ json
        self.poster_path = "poster_path" <~~ json
        self.release_date = "release_date" <~~ json
        self.popularity = "popularity" <~~ json
    }
    
    func poster_full_path()-> String {
//        return "https://image.tmdb.org/t/p/original/\(self.poster_path!)"
        // t/p/w500_and_h281_bestv2
         return "https://image.tmdb.org/t/p/w500_and_h281_bestv2/\(self.poster_path!)"
        
    }
    
    
    
}
