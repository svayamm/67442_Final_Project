//
//  UserJSONParser.swift
//  Busy
//
//  Created by Svayam Mishra on 06/12/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserJSONParser {

    
    class func parse(url: String){
        let theURL: NSURL = NSURL(string: url)!
        
        let data = NSData(contentsOf: theURL as URL)!
        let swiftyjson = JSON(data: data as Data)
        
//        if let owner_login = swiftyjson["items"][0]["owner"]["login"].string {
//            print(owner_login)
//        }
    }
}
