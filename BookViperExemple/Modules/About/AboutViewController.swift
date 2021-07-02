import UIKit
import Nuke

class AboutViewController: UIViewController {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleView: UILabel!
    @IBOutlet private var authorView: UILabel!
    @IBOutlet private var descriptionView: UITextView!
    @IBOutlet private var favouriteButton: UIButton!
    
    var book: Book!
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        showBook(book: book)
    }
    
    private func configure() {
        favouriteButton.roundCorners(corners: [.topLeft], radius: 20)
        
    }
    
    @IBAction func fafouritesTouchUpInside(_ sender: UIButton) {
        
    }
    
    
    func showBook(book: Book) {
        titleView.text = book.info.title
        authorView.text = book.info.authors?.compactMap({$0}).joined(separator: ", ")
        descriptionView.text = book.info.description ?? "Description empty"
        
        let emptyImage = UIImage(named: "emptyImage")
        if let urlString = book.info.imageLinks?.normal, let url = URL(string: urlString) {
            let options = ImageLoadingOptions(placeholder: emptyImage, failureImage: emptyImage)
            Nuke.loadImage(with: url, options: options, into: imageView)
        } else {
            imageView.image = emptyImage
        }
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
