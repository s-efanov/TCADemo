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

class UIKitTabVC: UIViewController, UISearchBarDelegate {
    private let store: StoreOf<TabReducer>
    private let uiKitLabel = UILabel(frame: .zero)
    private let stackView = UIStackView()
    private let searchStackView = UIStackView()
    private let searchButton = UIButton(type: .custom)
    private var textField: UITextField?
    
    init(store: StoreOf<TabReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiKitLabel.text = "UIKit"
        uiKitLabel.textAlignment = .center
        view.addSubview(uiKitLabel)
        uiKitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiKitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiKitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            uiKitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(searchStackView)
        searchStackView.axis = .horizontal
        searchStackView.spacing = 16

        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: uiKitLabel.bottomAnchor, constant: 16),
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        @UIBindable var store = store

        let searchBar = UITextField(frame: .zero, text: $store.searchText)
        self.textField = searchBar
        searchBar.placeholder = "Поиск"
        searchBar.autocorrectionType = .no
        searchBar.borderStyle = .roundedRect
        searchStackView.addArrangedSubview(searchBar)

        searchButton.setTitleColor(UIColor.blue, for: .normal)
        searchStackView.addArrangedSubview(searchButton)

        observe { [weak self] in
            guard let self else { return }
            
            if store.screenState.items.isEmpty {
                searchButton.setTitle("Найти", for: .normal)
                searchButton.removeTarget(self, action: #selector(onTapClear), for: .touchUpInside)
                searchButton.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
            } else {
                searchButton.setTitle("Очистить", for: .normal)
                searchButton.removeTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
                searchButton.addTarget(self, action: #selector(onTapClear), for: .touchUpInside)
            }

            switch store.screenState {
            case .initial:
                clearStackView()
                for item in store.calendarItems {
                    let eventView = CalendarEventView(calendarItem: item, onTapped: {
                        store.send(.ui(.onTapCalendarEvent(item)))
                    })
                    stackView.addArrangedSubview(eventView)
                }
            case .loading:
                let activity = UIActivityIndicatorView(style: .medium)
                activity.startAnimating()
                stackView.addArrangedSubview(activity)
            case let .searchResult(results):
                clearStackView()
                for item in results {
                    let eventView = SearchItemUIView(searchItem: item, onTapped: {
                        store.send(.ui(.onTapSearchItem(item)))
                    })
                    stackView.addArrangedSubview(eventView)
                }
            case .searchError:
                break
            }
        }
        
        store.send(.onAppear)
    }
    
    func clearStackView() {
        for subView in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
    
    @objc func onTapSearch() {
        store.send(.ui(.onTapStartSearch))
    }
    
    @objc func onTapClear() {
        textField?.resignFirstResponder()
        store.send(.ui(.onTapClear))
    }
}

class SearchItemUIView: UIView {
    let searchItem: SearchItem
    let onTapped: () -> Void
    
    init(searchItem: SearchItem, onTapped: @escaping () -> Void) {
        self.searchItem = searchItem
        self.onTapped = onTapped
        super.init(frame: .zero)
        
        let label = UILabel(frame: .zero)
        label.text = searchItem.title
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
        addGestureRecognizer(recognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTapGesture() {
        onTapped()
    }
}

class CalendarEventView: UIView {
    let calendarItem: CalendarItem
    let onTapped: () -> Void
    private let vStack = UIStackView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let timeLabel = UILabel(frame: .zero)
    
    init(calendarItem: CalendarItem, onTapped: @escaping () -> Void) {
        self.calendarItem = calendarItem
        self.onTapped = onTapped
        super.init(frame: .zero)
        
        vStack.spacing = 4
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        titleLabel.text = calendarItem.title
        titleLabel.textColor = .systemBlue
        vStack.addArrangedSubview(titleLabel)
        
        timeLabel.text = calendarItem.from + " - " + calendarItem.to
        timeLabel.textColor = .systemBlue
        vStack.addArrangedSubview(timeLabel)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
        addGestureRecognizer(recognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onTapGesture() {
        onTapped()
    }
}


class UIKitNavController: NavigationStackController {
    private var store: StoreOf<TabReducer>!
    
    convenience init(store: StoreOf<TabReducer>) {
        @UIBindable var store = store
        
        self.init(path: $store.scope(state: \.path, action: \.path)) {
            UIKitTabVC(store: store)
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
