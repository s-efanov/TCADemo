//
//  SecondView.swift
//  TCADemo
//
//  Created by Sergei Efanov on 19.09.2024.
//

import SwiftUI
import UIKit
import ComposableArchitecture

struct UIKitTabView: View {
    let store: StoreOf<TabReducer>
    
    var body: some View {
        WithPerceptionTracking {
            UIViewControllerRepresenting {
                UIKitNavController(store: store)
            }
        }
    }
}

class TabVC: UIViewController {
    private let store: StoreOf<TabReducer>
    private let stackView = UIStackView()
    private let uiKitCounterButton = UIButton(type: .custom)
    private let uiKitWeatherButton = UIButton(type: .custom)
    
    init(store: StoreOf<TabReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(uiKitCounterButton)
        stackView.addArrangedSubview(uiKitWeatherButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        uiKitCounterButton.setTitle("UIKit Counter", for: .normal)
        uiKitCounterButton.setTitleColor(.systemBlue, for: .normal)

//        uiKitCounterButton.addAction(
//            UIAction { [weak self] _ in self?.store.send(.onTapUIKitCounterButton) },
//            for: .touchUpInside
//        )

        uiKitWeatherButton.setTitle("UIKit Weather", for: .normal)
        uiKitWeatherButton.setTitleColor(.systemBlue, for: .normal)
//        uiKitWeatherButton.addAction(
//            UIAction { [weak self] _ in self?.store.send(.onTapUIKitWeatherButton) },
//            for: .touchUpInside
//        )
    }
}


class UIKitNavController: NavigationStackController {
    private var store: StoreOf<TabReducer>!
    
    convenience init(store: StoreOf<TabReducer>) {
        @UIBindable var store = store
        
        self.init(path: $store.scope(state: \.path, action: \.path)) {
            TabVC(store: store)
        } destination: { store in
            switch store.case {
            case .profile(let store):
                ProfileVC(store: store)
            case .event(let store):
                EventVC(store: store)
            }
        }
    }
}
