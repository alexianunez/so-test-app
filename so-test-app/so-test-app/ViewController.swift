//
//  ViewController.swift
//  so-test-app
//
//  Created by Alexia Nunez on 1/9/18.
//  Copyright © 2018 Alexia Nunez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let kDetailVCID: String = "DetailViewController"
    
    var dataSource: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Latest Questions"
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
    
    fileprivate func toggleNetworkIndicator(toggle: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = toggle
        }
    }

}

extension ViewController {
    
    fileprivate func fetchData() {
        
        let restClient = RestClient()
        
        let urlString = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow"
        
        restClient.fetchData(urlString: urlString) { [weak self] (response) in
        
        self?.toggleNetworkIndicator(toggle: true)
        
            guard
                response.1 == nil,
                let questions = response.0 else {
                    print(response.1!.localizedDescription)
                    self?.toggleNetworkIndicator(toggle: false)
                    return
            }
            
            let _ = questions.map({ (question) in
                self?.dataSource.append(question)
            })
            self?.toggleNetworkIndicator(toggle: false)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        let question = dataSource[indexPath.row]
        
        cell.questionTitle.text = question.title
        cell.detailsLabel.text = "Answer count: \(question.answerCount) Score: \(question.score)"
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let storyboard = self.storyboard,
        let detailVC = storyboard.instantiateViewController(withIdentifier: kDetailVCID) as? DetailViewController
            else {
                return
        }
        // Config here!
        let question = dataSource[indexPath.row]
        detailVC.question = question
        self.navigationController?.show(detailVC, sender: self)
    }
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
}


