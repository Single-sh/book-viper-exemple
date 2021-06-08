import UIKit

class TabNavigationView: UIView {
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    private let horizontalSpaceing: CGFloat = 30
    private let verticalSpaceing: CGFloat = 25
    private var tabBarItemView = [TabBarItemViewProtocol]()
    
    func setupView(tabItems: [TabItem]) {
        configureView()
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalSpaceing),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -horizontalSpaceing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalSpaceing),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: verticalSpaceing)
        ])
        
        
        for at in 0...tabItems.count-1 {
            let tabItemView = TabBarItemView.newInstance
            tabItemView.configureView(tabItem: tabItems[at]) { [weak self] in
                guard let selected = self?.activeItem, selected != at else { return }
                self?.tabBarItemView[selected].updateTabUI(isSelected: false)
                self?.tabBarItemView[at].updateTabUI(isSelected: true)
                self?.activeItem = at
                self?.itemTapped?(at)
            }
            tabBarItemView.append(tabItemView)
            stackView.addArrangedSubview(tabItemView)
        }
        tabBarItemView.first?.updateTabUI(isSelected: true)
    }
    
    private func configureView() {
        layer.cornerRadius = 20
        backgroundColor = UIColor(red: 0.958, green: 0.958, blue: 0.958, alpha: 0.75)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = frame
        addSubview(blurredEffectView)
    }
    
    @objc func tapButton(button: UIButton) {
        itemTapped?(button.tag)
    }
}
