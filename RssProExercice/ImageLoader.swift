//
//  ImageLoader.swift
//  RssProExercice
//
//  Created by Fabien Brun on 17/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit


/*
 *
 *  Service loading image
 *  Take an URL String params
 *  Callback UIImage
 *
 */


class ImageLoader {
    
    func load(url_image: String , callBack:@escaping (UIImage)-> Void) {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let url = URL(string: url_image)!
        let session = URLSession(configuration: config) // Load configuration into Session
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let image = try UIImage(data: data!)
                    {
                        callBack(image)
                    }
                    
                } catch {
                    print("error UIImage")
                }
                
            }
            
        })
        task.resume()

    }
    
    
    
    
    
    
    

}
