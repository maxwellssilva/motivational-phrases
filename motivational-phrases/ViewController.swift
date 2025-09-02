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
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var newPhraseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Nova frase", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.backgroundColor = UIColor(named: "verde-escuro")
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newPhraseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var phraseLabel: UILabel = {
        let phrase = UILabel()
        phrase.text = "Carregando frase..."
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
        randomPhrase()
    }
    
    func randomPhrase() {
        var frases: [String] = []
        frases.append("Se estiver se sentindo desmotivado ou sentindo que não é bom o suficiente, incendeie seu coração.")
        frases.append("Eu te amaria em todos os universos")
        frases.append("A obsessão ganha do talento todas às vezes")
        
        phraseLabel.text = frases.randomElement()
    }
    
    @objc private func newPhraseButtonTapped() {
        randomPhrase()
    }
    
    private func setupLayout() {
        view.addSubview(logoImage)
        view.addSubview(phraseLabel)
        view.addSubview(newPhraseButton)
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            
            phraseLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor),
            phraseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phraseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phraseLabel.bottomAnchor.constraint(equalTo: newPhraseButton.topAnchor),
            
            newPhraseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            newPhraseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            newPhraseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            
        ])
    }
}
