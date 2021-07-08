import UIKit
import Nuke

class AboutViewController: UIViewController {
    
    private var presenter: AboutPresenterProtocol!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleView: UILabel!
    @IBOutlet private var authorView: UILabel!
    @IBOutlet private var descriptionView: UITextView!
    @IBOutlet private var favouriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteButton.isHidden = true
        configure()
        presenter.viewDidLoad()
    }
    
    func setPresenter(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func configure() {
        favouriteButton.roundCorners(corners: [.topLeft], radius: 20)
        
    }
    
    @IBAction func fafouritesTouchUpInside(_ sender: UIButton) {
        presenter.favouriteButtonTap()
    }
}

extension AboutViewController: AboutViewProtocol {
    func showBook(book: BookProtocol) {
        titleView.text = book.title
        authorView.text = book.authors?.compactMap({$0}).joined(separator: ", ")
        descriptionView.text = book.descriptionBook ?? "Description empty"
        
        let emptyImage = UIImage(named: "emptyImage")
        if let urlString = book.thumbnail, let url = URL(string: urlString) {
            let options = ImageLoadingOptions(placeholder: emptyImage, failureImage: emptyImage)
            Nuke.loadImage(with: url, options: options, into: imageView)
        } else {
            imageView.image = emptyImage
        }
    }
    
    func setupFavourite(action: FavouriteAction) {
        favouriteButton.setTitle(action.rawValue, for: .normal)
        favouriteButton.tintColor = action.tintColor
        favouriteButton.isHidden = false
    }
    
    
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
