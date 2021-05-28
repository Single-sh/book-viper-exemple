import UIKit
import Nuke

class MainViewController: UIViewController {
    private let identifierCell = "book"
    private var presenter: MainPresenterProtocol!
    
    @IBOutlet private var tableView: UITableView!
    private var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.searchBooks(search: "swift")
        configure()
    }
    
    func setPresenter(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "BookCell", bundle: nil),
            forCellReuseIdentifier: identifierCell
        )
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
        if let url = URL(string: book.info.imageLinks.small), let imageView = cell.imageView {
            Nuke.loadImage(with: url, into: imageView)
        }
        return cell
    }
    
    
}
