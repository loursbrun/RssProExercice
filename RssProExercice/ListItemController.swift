//
//  ListViewController.swift
//  RssProExercice
//
//  Created by Fabien Brun on 13/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit

class ListItemController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var MainCollectionView: UICollectionView!
    
    var news = [RssItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*          
         * Add the logo to navigation bar
         */
        navigationBarSetup()
        
        
        /* 
         *  Call and Parse the  rss flux width RssReader service (asynchronously)
         *  return callback of [RssItem] array
         */
        RssReader.sharedInstance.parseNews {
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
    
    internal func navigationBarSetup() {
        /*
         * Custom navigation bar - add image & chnage back title word
         */

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "lemonde")
        imageView.image = image
        navigationItem.titleView = imageView
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Retour", style:.plain, target:nil, action:nil)

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
         *  The title and the image are updated according to (indexPath.row) which itterates in the table of news
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
     *  Small margins for cells
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
         *  The controller of the Details view is intensified by passing the values of the clicked cell
         */
        let desCV = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        desCV.getName = self.news[indexPath.row].title_model!
        desCV.getDescription = self.news[indexPath.row].description_model!
        desCV.getImage = self.news[indexPath.row].enclosure_url_image!
        desCV.getLinkNews = self.news[indexPath.row].link_model!
        
        self.navigationController?.pushViewController(desCV, animated: true)
        
    }


}

