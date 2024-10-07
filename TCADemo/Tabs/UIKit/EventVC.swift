import UIKit
import ComposableArchitecture

class EventVC: UIViewController {
    let store: StoreOf<EventReducer>
    private let label = UILabel()
    private let activityView = UIActivityIndicatorView()
    
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
        
        view.addSubview(label)
        label.text = ""
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityView.hidesWhenStopped = true
        
//        observe { [weak self] in
//            guard let self else { return }
//            if store.isLoading {
//                activityView.startAnimating()
//            } else {
//                activityView.stopAnimating()
//            }
//            if let temperature = store.temperature {
//                label.text = "\(String(format: "%.1f", temperature)) ℃"
//            }
//        }
//        
//        store.send(.onAppear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}
