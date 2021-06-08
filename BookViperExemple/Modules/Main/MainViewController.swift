import UIKit
import Nuke

final class MainViewController: UIViewController {
    private let identifierCell = "book"
    private var presenter: MainPresenterProtocol!
    
    @IBOutlet private var tableView: UITableView!
    private var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.searchBooks(search: "детские сказки")
        configure()
    }
    
    func setPresenter(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "BookCell", bundle: nil),
            forCellReuseIdentifier: identifierCell
        )
        
        tableView.addSubview(UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 0)))
        tableView.addSubview(UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100)))
    }

}

extension MainViewController: MainViewProtocol {
    func showBooks(books: [Book]) {
        self.books = books
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.info.title
//        if let url = URL(string: book.info.imageLinks.small), let imageView = cell.imageView {
//            Nuke.loadImage(with: url, into: imageView)
//        }
        return cell
    }
    
    
}
