import UIKit
protocol TabBarItemViewProtocol: UIView {
    func configureView(tabItem: TabItem, itemTapped: (() -> Void)?)
    func updateTabUI(isSelected: Bool)
}

class TabBarItemView: UIView {
    var item: TabItem!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var labelView: UILabel!
    private var itemTapped: (() -> Void)?
    
    static var newInstance: TabBarItemViewProtocol {
        return Bundle.main.loadNibNamed(
            String(describing: TabBarItemView.self),
            owner: nil,
            options: nil
        )?.first as! TabBarItemViewProtocol
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture()
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(handleGesture(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleGesture(_ sender: UITapGestureRecognizer) {
        itemTapped?()
    }

}

extension TabBarItemView: TabBarItemViewProtocol {
    
    func configureView(tabItem: TabItem, itemTapped: (() -> Void)?) {
        item = tabItem
        self.itemTapped = itemTapped
        labelView.text = ""
        imageView.image = item.icon
        imageView.tintColor = .black
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 25
    }
    
    func updateTabUI(isSelected: Bool) {
        let options: UIView.AnimationOptions = isSelected ? [.curveEaseIn] : [.curveEaseOut]
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.5,
            options: options,
            animations: { [weak self] in
                guard let self = self else { return }
                self.labelView.text = isSelected ? self.item.rawValue.uppercased() : ""
                let color: UIColor = isSelected ? .white : .clear
                self.contentView.backgroundColor = color
                (self.superview as? UIStackView)?.layoutIfNeeded()
            }, completion: nil)
    }
}
