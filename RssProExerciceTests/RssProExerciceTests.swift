//
//  RssProExerciceTests.swift
//  RssProExerciceTests
//
//  Created by Fabien Brun on 13/04/2017.
//  Copyright © 2017 fabienbrun. All rights reserved.
//

import XCTest
@testable import RssProExercice



/*
 *  Tests unitaires à metre en place
 *
 *  tester la validitée de l'URL du flux RSS
 *  tester le service de parsing
 * 
 *  étudier les autres tests à éffectuer
 */




class RssProExerciceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testRssReaderLemondeUneXml() {
        
        RssReader.sharedInstance.parseNews (url_rss: "http://www.lemonde.fr/rss/une.xml"){
            paramsCallBack in
            DispatchQueue.main.async {
            }
        }
        
    }
    
    
}
