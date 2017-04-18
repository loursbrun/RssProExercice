//
//  DetailViewController.swift
//  RssProExercice
//
//  Created by Fabien Brun on 13/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
   
    
    /*
     *  On récupère les paramétres passés par le ViewController
     */
    var getName = String()
    var getImage = String()
    var getDescription = String()
    var getLinkNews = String()
    
    
    @IBAction func btnAction(_ sender: Any) {
        /*
         *  Action sur le bouton Lire l'article
         *  ouvre la webview de Safari avec l'url de la news
         */
        openNews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        /*
         *  On met à jour les éléments de la vue
         */
        lblName.text! = getName
        lblDescription.text! = getDescription
        
        
        /*
         *  Service ImageLoader -> callback a UIImage
         */
        ImageLoader.init().load (url_image: getImage){
          (paramsCallBack,error) in
            guard error == nil else {
                
                let alert = UIAlertController(title: "error", message: "error calling ImageLoader \(error!)", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(defaultAction)
                self.present(alert, animated: true, completion: nil)
                return
            }

            DispatchQueue.main.async {
                self.imgImage.image = paramsCallBack
            }

        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func openNews() {
        
        // Split de l'url pour retirer les parametres après le ?
        let linkToSplit = getLinkNews
        let separators = CharacterSet(charactersIn: "?")
        let parts = linkToSplit.components(separatedBy: separators)
        
        if let url = URL(string: parts[0]) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
}
