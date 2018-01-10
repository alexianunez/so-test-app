//
//  ViewController.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/9/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let restClient = RestClient()
    
    let urlString = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        restClient.fetchData(urlString: urlString) { (response) in
            
            guard
                response.1 == nil,
                let questions = response.0 else {
                print(response.1!.localizedDescription)
                return
            }
            
            for question: Question in questions {
                print(question.title)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

