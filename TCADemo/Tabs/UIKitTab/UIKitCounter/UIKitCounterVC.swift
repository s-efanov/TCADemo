//
//  Feature3VC.swift
//  TCADemo
//
//  Created by Sergei Efanov on 21.09.2024.
//

import UIKit
import ComposableArchitecture

class UIKitCounterVC: UIViewController {
    let store: StoreOf<UIKitCounterReducer>
    private let label = UILabel()
    private let plusButton = UIButton(type: .custom)
    private let minusButton = UIButton(type: .custom)
    
    init(store: StoreOf<UIKitCounterReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(minusButton)
        
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.addAction(
            UIAction { [weak self] _ in self?.store.send(.onTapMinusButton) },
            for: .touchUpInside
        )
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
            minusButton.topAnchor.constraint(equalTo: label.bottomAnchor),
            minusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20)
        ])
        
        view.addSubview(plusButton)
        
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.addAction(
            UIAction { [weak self] _ in self?.store.send(.onTapPlusButton) },
            for: .touchUpInside
        )
        
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            plusButton.topAnchor.constraint(equalTo: label.bottomAnchor),
            plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20)
        ])

        observe { [weak self] in
            guard let self else { return }
            label.text = "Count: \(store.counter)"
        }
    }
}
