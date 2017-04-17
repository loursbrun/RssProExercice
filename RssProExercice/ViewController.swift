//
//  ViewController.swift
//  RssProExercice
//
//  Created by Fabien Brun on 13/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var MainCollectionView: UICollectionView!
    
    var news = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*          
         * Ajout du logo dans la navigation bar
         */
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "lemonde")
        imageView.image = image
        navigationItem.titleView = imageView
      
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Retour", style:.plain, target:nil, action:nil)
        
        
        
        /* 
         *  Appel du service qui Parse le flux de manière asynchrone
         *  et retourne en callback le tableau d'objet NewsModel
         */
        XMLParserService.sharedInstance.parseNews {
            paramsCallBack in
            
            DispatchQueue.main.async {
                self.news = paramsCallBack
                /*
                 *  Reload la collection view
                 */
                self.MainCollectionView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        /*
         *  On met à jour le titre et l'image en fonction avec ( indexPath.row ) qui ittère dans le tableau de news
         */
        let url = URL(string: self.news[indexPath.row].enclosure_url_image!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                cell.imgImage.image = UIImage(data: data!)
            }
        }
        cell.lblName.text! = self.news[indexPath.row].title_model!
        return cell
    } 
    
    
    /*
     *  Petites marges pour les cellules
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
         *  On intencie le controller de la vue Détails en passant les valeurs de la cellule cliquée
         */
        let desCV = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        desCV.getName = self.news[indexPath.row].title_model!
        desCV.getDescription = self.news[indexPath.row].description_model!
        desCV.getImage = self.news[indexPath.row].enclosure_url_image!
        desCV.getLinkNews = self.news[indexPath.row].link_model!
        
        self.navigationController?.pushViewController(desCV, animated: true)
        
    }


}

