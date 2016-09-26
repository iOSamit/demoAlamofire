//
//  ViewController.swift
//  demoAlamofire
//
//  Created by Amit on 26/09/2015 SAKA.
//  Copyright © 2016 Dream World. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func login(){
        Alamofire.request(.POST, "http://LoginWebServiceURL", parameters: ["userName": "Amit1","password": "q123456"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }

    }
    func uploadImageAndData(){
        let gender    = "M"
        let firstName = "firstName"
        let lastName  = "lastName"
        let dob       = "11-Jan-2000"
        let aboutme   = "aboutme"
        let token     = "56c2e60e-21d8-47f7-bf4a-41bc2d717a3b"
        
        
        var parameters = [String:AnyObject]()
        parameters = ["gender":gender,"firstName":firstName,"dob":dob,"aboutme":aboutme,"token":token,"lastName":lastName]
        
        let URL = "WebServcieURLForDataAndImageBoth"
        
        let  image = UIImage(named: "image.png")
        
        Alamofire.upload(.POST, URL, multipartFormData: {
            multipartFormData in
            
            
            if  let imageData = UIImageJPEGRepresentation(image!, 0.6) {
                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
            }
            
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, encodingCompletion: {
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    print("s")
                    
                    upload.responseJSON { response in
                        print(response.request)  // original URL request
                        print(response.response) // URL response
                        print(response.data)     // server data
                        print(response.result)   // result of response serialization
                        
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                        }
                    }
                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

