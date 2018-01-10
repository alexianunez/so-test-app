//
//  ViewController.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/9/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dataSource = []
    }

}

extension ViewController {
    
    fileprivate func fetchData() {
        
        let restClient = RestClient()
        
        let urlString = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow"
        
        restClient.fetchData(urlString: urlString) { [weak self] (response) in
            
            guard
                response.1 == nil,
                let questions = response.0 else {
                    print(response.1!.localizedDescription)
                    return
            }
            
            let _ = questions.map({ (question) in
                self?.dataSource.append(question)
            })
        }
    }
}

