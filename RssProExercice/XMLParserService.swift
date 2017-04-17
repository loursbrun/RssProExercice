//
//  XMLParserService.swift
//  RssProExercice
//
//  Created by Fabien Brun on 13/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import UIKit


class XMLParserService: NSObject, XMLParserDelegate {
    
    
    static let sharedInstance = XMLParserService()
    
    let URL_NEWS = "http://www.lemonde.fr/rss/une.xml"
    
    var newsArray = [RssItem]()
    
    
    //Declaration des tableaux, dictionnaires, chaines de caractères
    var xmlParser = XMLParser()
    var strElement = String()
    var strTitle = String()
    var strLink = String()
    var strDescription = String()
    var strUrlImg = String()
    var isNeedToGetItemData = false
    
    
    // On parse l'url RSS qui renvoit un xml
    func parseNews(callBack:@escaping ([RssItem])-> Void) {
        
        let url = NSURL(string: URL_NEWS)
        xmlParser = XMLParser(contentsOf: url! as URL)!
        xmlParser.delegate = self
        xmlParser.parse()
        
        callBack(newsArray)
    }
    
    
    // XMLParser Delegates
    func parserDidStartDocument(_ parser: XMLParser) {
        //On commence le parsing
    }
    
    func parser(_ parser: XMLParser,didStartElement elementName: String,namespaceURI: String?,qualifiedName qName: String?,attributes attributeDict:[String : String] = [:]) {
        strElement = elementName
        if strElement == "item" {
            isNeedToGetItemData = true
            //Re-initialise
            strTitle = String()
            strLink = String()
            strDescription = String()
        }
        if strElement == "enclosure" {
            if let urlString = attributeDict["url"] {
                strUrlImg = urlString
            } else {
                print("Error of url attribute")
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isNeedToGetItemData == true && string != "\n" {
            if strElement == "title" {
                strTitle.append(string)
            }
            else if strElement == "link" {
                strLink.append(string)
            }
            else if strElement == "description" {
                strDescription.append(string)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            // Ajoute une News au tableau de news
            let news = RssItem()
            news.link_model = strLink
            news.title_model = strTitle
            news.description_model = strDescription
            news.enclosure_url_image = strUrlImg
            
            newsArray.append(news)
            
            //Met le flag à false
            isNeedToGetItemData = false
        }
        
    }
    
}
























