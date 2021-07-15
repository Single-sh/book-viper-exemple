import UIKit
import Nuke

final class BookCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.cornerRadius = 10
        backgroundColor = .white
    }
    
    func setInfo(book: BookProtocol) {
        let emptyImage = UIImage(named: "emptyImage")
        if let urlString = book.thumbnail, let url = URL(string: urlString) {
            let options = ImageLoadingOptions(placeholder: emptyImage, failureImage: emptyImage)
            Nuke.loadImage(with: url, options: options, into: imageView)
        } else {
            imageView.image = emptyImage
        }
    }
    
}
