//
//  Tagalong.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/6/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

struct Tagalong{
    
    var date: String
    var latitude: Double
    var longitude: Double
    var restaurant: String
    var user: User!
    var guest = ""
    
    init(snapshot: [String:Any]) {
        print(snapshot)
        let date = snapshot["date"] as! String
        let location = snapshot["location"] as! [String: Any]
        let latitude = location["lat"] as! Double
        let longitude = location["long"] as! Double
        let restaurant = location["restaurant"] as! String
        let user = snapshot["user"] as! String
        
        // Need to set location to equal dictionary of lat, long, restaurant
        self.date = date
        self.longitude = longitude
        self.latitude = latitude
        self.restaurant = restaurant
    
        
    }

}
