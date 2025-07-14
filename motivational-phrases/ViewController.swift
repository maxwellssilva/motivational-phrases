//
//  ViewController.swift
//  motivational-phrases
//
//  Created by Maxwell Silva on 04/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var newPhraseButton: UIButton = {
        let button = UIButton()
        button.setTitle("New phrase", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var phraseLabel: UILabel = {
        let phrase = UILabel()
        phrase.text = "Frase do dia"
        phrase.numberOfLines = 0
        phrase.textAlignment = .center
        phrase.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)
        phrase.translatesAutoresizingMaskIntoConstraints = false
        return phrase
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    func fetchDataAPI() {
        NetworkManager.shared.fetchData(from: "https://docapi.dev/books/api-de-frases/page/obter-todas") { (result: Result<[Quote], APIError) in
            switch result {
            case .success(let quotes):
                print("Frases recebidas com sucesso!")
                for quote in quotes {
                    print("Quote: \(quote.quote)")
                    print("Author: \(quote.author)")
                    print("---")
                }
            case .failure(let error):
                print("Erro ao buscar frases: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(logoImage)
        view.addSubview(phraseLabel)
        view.addSubview(newPhraseButton)
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            newPhraseButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
            newPhraseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            newPhraseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            
            phraseLabel.topAnchor.constraint(equalTo: newPhraseButton.bottomAnchor, constant: 50),
            phraseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phraseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}

