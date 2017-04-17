//
//  RssReader.swift
//  RssProExercice
//
//  Created by Fabien Brun on 13/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//



/*
 *
 *  This service read the RSS Flux 
 *  Parse and crea
 *  Parse and put in a array all found item
 *
 */




import UIKit


class RssReader: NSObject, XMLParserDelegate {
    
    
    static let sharedInstance = RssReader()
    
    let URL_NEWS = "http://www.lemonde.fr/rss/une.xml"
    
    var newsArray = [RssItem]()
    
    
    //Declaration of variables types
    var xmlParser = XMLParser()
    var itemElement = String()
    var itemTitle = String()
    var itemLink = String()
    var itemDescription = String()
    var itemUrlImg = String()
    var isNeedToGetItemData = false
    
    
    // We parse the RSS url that returns an xml
    func parseNews(callBack:@escaping ([RssItem])-> Void) {
        
        let url = NSURL(string: URL_NEWS)
        xmlParser = XMLParser(contentsOf: url! as URL)!
        xmlParser.delegate = self
        xmlParser.parse()
        
        callBack(newsArray)
    }
    
    
    // XMLParser Delegates
    internal func parserDidStartDocument(_ parser: XMLParser) {
        //Begining the parsing
    }
    
    internal func parser(_ parser: XMLParser,didStartElement elementName: String,namespaceURI: String?,qualifiedName qName: String?,attributes attributeDict:[String : String] = [:]) {
        itemElement = elementName
        if itemElement == "item" {
            isNeedToGetItemData = true
            //Re-initialise
            itemTitle = String()
            itemLink = String()
            itemDescription = String()
        }
        if itemElement == "enclosure" {
            if let urlString = attributeDict["url"] {
                itemUrlImg = urlString
            } else {
                print("Error of url attribute")
            }
        }
    }
    
    internal func parser(_ parser: XMLParser, foundCharacters string: String) {
        if isNeedToGetItemData == true && string != "\n" {
            if itemElement == "title" {
                itemTitle.append(string)
            }
            else if itemElement == "link" {
                itemLink.append(string)
            }
            else if itemElement == "description" {
                itemDescription.append(string)
            }
        }
    }
    
    internal func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            
            // Add a news to the news array
            let news = RssItem()
            news.link_model = itemLink
            news.title_model = itemTitle
            news.description_model = itemDescription
            news.enclosure_url_image = itemUrlImg
            
            newsArray.append(news)
            
            //Pass the flag to false
            isNeedToGetItemData = false
        }
        
    }
    
}
























