//
//  ImageLoader.swift
//  RssProExercice
//
//  Created by Fabien Brun on 17/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit


enum ImageLoaderError: Error {
    case networkError(error: Error)
  }

/*
 *
 *  Service loading image
 *  Take an URL String params
 *  Callback UIImage
 *
 */

class ImageLoader {
    
    func load(url_image: String , callBack:@escaping (UIImage?, ImageLoaderError?)-> Void) {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let url = URL(string: url_image)!
        let session = URLSession(configuration: config) // Load configuration into Session
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling ImageLoader: \(error!)")
                callBack(nil, .networkError(error: error!))
                
                return
            }
            
            do {
                if let image = try UIImage(data: data!)
                {
                  callBack(image,nil)
                }
                
                } catch {
                  print("error UIImage")
              }


        })
        task.resume()

    }
    

}
