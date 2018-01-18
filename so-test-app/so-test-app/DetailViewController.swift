//
//  DetailViewController.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/18/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var question: Question?
    
    let client = RestClient()
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


        
       fetchImage()
    }

}

fileprivate extension DetailViewController {
    func fetchImage() {
        guard let q = question else {
            return
        }
        client.fetchImageData(urlString: q.owner.imageUrl) { (image) in
            if let img = image {
                DispatchQueue.main.async { [weak self] in
                    self?.profileImageView.image = img
                }
            }
        }
    }
}
