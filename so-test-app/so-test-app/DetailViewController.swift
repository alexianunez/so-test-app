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
    @IBOutlet weak var authorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let q = question else { return }
        populateUI(question: q)
    }

}

fileprivate extension DetailViewController {
    
    func populateUI(question: Question) {
        fetchImage(question: question)
        buildQuestionString(question: question)
        authorLabel.text = question.owner.author
    }
    
    func buildQuestionString(question: Question) {
        questionTextView.text = question.title
    }
    
    func fetchImage(question: Question) {
        
        client.fetchImageData(urlString: question.owner.imageUrl) { (image) in
            if let img = image {
                DispatchQueue.main.async { [weak self] in
                    self?.profileImageView.image = img
                }
            }
        }
    }
}
