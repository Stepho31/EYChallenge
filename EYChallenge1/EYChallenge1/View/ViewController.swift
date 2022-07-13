//
//  ViewController.swift
//  EYChallenge1
//
//  Created by Stephen on 7/11/22.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var topLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Async Await"
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Closure"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        
        // MARK: Fetch to async / await implementation
        
        Task {
            let ipModel: IPModel? = await NetworkService.getDataAsyncAwait()
            
            DispatchQueue.main.async {
                self.topLabel.text = ipModel?.ip
            }
        }
        
        // MARK: Fetch to closure implementation
        
        NetworkService.getDataClosure { [weak self] (model: IPModel?) in
            guard let ip = model?.ip else { return }
            DispatchQueue.main.async {
                self?.bottomLabel.text = ip
            }
        }
        
        
    }
    
    private func createUI() {
        self.view.addSubview(self.topLabel)
        self.view.addSubview(self.bottomLabel)
        
        self.topLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.topLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.topLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        self.bottomLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.bottomLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.bottomLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }


}

