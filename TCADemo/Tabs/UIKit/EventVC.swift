import UIKit
import ComposableArchitecture

class EventVC: UIViewController {
    let store: StoreOf<EventReducer>
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let uiKitLabel = UILabel()
    private let calendarStackView = UIStackView()
    
    init(store: StoreOf<EventReducer>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        
        view.addSubview(calendarStackView)
        calendarStackView.axis = .vertical
        calendarStackView.alignment = .center
        calendarStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        calendarStackView.addArrangedSubview(titleLabel)
        calendarStackView.addArrangedSubview(timeLabel)

        observe { [weak self] in
            guard let self else { return }
            titleLabel.text = store.calendarItem.title
            timeLabel.text = store.calendarItem.from + " - " + store.calendarItem.to
        }
    }
}
