import UIKit
import ComposableArchitecture

class ProfileVC: UIViewController {
    let store: StoreOf<ProfileReducer>
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    private let uiKitLabel = UILabel()
    private let personStackView = UIStackView()
    
    init(store: StoreOf<ProfileReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(uiKitLabel)
        uiKitLabel.text = "UIKit"
        uiKitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiKitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiKitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        view.addSubview(personStackView)
        personStackView.axis = .vertical
        personStackView.alignment = .center
        personStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        personStackView.addArrangedSubview(nameLabel)
        personStackView.addArrangedSubview(typeLabel)

        observe { [weak self] in
            guard let self else { return }
            nameLabel.text = store.searchItem.title
            typeLabel.text = store.searchItem.type
        }
    }
}
