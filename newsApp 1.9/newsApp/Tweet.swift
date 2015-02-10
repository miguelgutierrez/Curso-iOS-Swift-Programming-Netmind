//
//  Tweet.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 30/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class Tweet {
    var iden : String?
    var texto : String?
    var creado : NSDate?
    
    init () {
        
    }
    
    convenience init? (anyObject: AnyObject){
        
        if let tweet = anyObject as? NSDictionary {
            self.init (atributtes:tweet)
        }
        else{
            self.init()
            return nil
        }
    }
    convenience init (atributtes: NSDictionary){
        self.init()
        
        // NSLog("tweet dictionary \(atributtes)")
        
        if let iden = atributtes.valueForKey("id_str") as? String {
            self.iden = iden
        }
        if let text = atributtes.valueForKey("text") as? String {
            self.texto = text
        }

        if let fecha = atributtes.valueForKey("created_at") as? String {
            let df = NSDateFormatter()
            df.locale=NSLocale(localeIdentifier: "en_EN")
            df.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy";// Wed, Jun 25 10:33:57 +0000 2013
            
            self.creado = df.dateFromString(fecha)
        }
    }

    func isEqual(object : AnyObject){
        
    }
    
    class func ultimosPost(completionBlock:(post:[Tweet]?, error: NSError?) -> (), withTotal total:Int) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let twitter = twitterAPIClient()
        
        
        twitter.verifyCredentialsWithSuccessBlock({ (userName:String!) -> Void in
            NSLog("credenciales verificadas. Username: \(userName)")
            
            twitter.getSearchTweetsWithQuery("iOS", geocode: nil, lang: nil, locale: nil, resultType: nil, count: "\(total)", until: nil, sinceID: nil, maxID: nil, includeEntities: nil, callback: nil, successBlock: { (arrayDictionary:[NSObject : AnyObject]!, valores:[AnyObject]!) -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                NSLog("Leídos: \(valores.count)")
                
                var tweets = [Tweet]()
                for valor in valores {
                    if let tweet = Tweet (anyObject: valor) {
                        tweets.append(tweet)
                    }
                }
                    completionBlock(post: tweets,error: nil)
                
                },
                errorBlock: { (error: NSError!) -> Void in
                    NSLog("Error: \(error)")
                    completionBlock(post: nil,error: nil)
            })
            
            
            },
            errorBlock: { (error: NSError!) -> Void in
                completionBlock(post: nil, error: error)
                NSLog("Error credenciales")
        })
    }
    
    
    // MARK: métodos de ayuda
    private func parametrosBusqueda() -> NSString
    {
        return "iOS";
    }

}
