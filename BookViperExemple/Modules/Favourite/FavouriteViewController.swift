import UIKit

final class FavouriteViewController: UIViewController {
    private var presenter: FavouritePresenterProtocol!
    private let cellSpace: CGFloat = 20
    private var collection = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    
    func setPresenter(presenter: FavouritePresenterProtocol) {
        self.presenter = presenter
    }
    
    

    private func setupUI() {
        collection.backgroundColor = .clear
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collection.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: BookCollectionViewCell.self)
        )
        collection.dataSource = self
        collection.delegate = self
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        collection.refreshControl = refresh
        
        presenter.viewDidLoad()
    }
    
    @objc private func onRefresh() {
        presenter.viewDidLoad()
    }
}

extension FavouriteViewController: FavouriteViewProtocol {
    func updateData() {
        collection.refreshControl?.endRefreshing()
        collection.reloadData()
    }
}

extension FavouriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BookCollectionViewCell.self),
            for: indexPath
        ) as! BookCollectionViewCell
        let book = presenter.getBook(indexPath: indexPath)
        cell.setInfo(book: book)
        return cell
    }
    
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let columns: CGFloat = traitCollection.horizontalSizeClass == .compact ? 2 : 4
        let width = (collection.bounds.width - columns * cellSpace - cellSpace) / columns
        let height = width + (width / 100 * 50)
        return .init(width: width, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .init(top: cellSpace, left: cellSpace, bottom: 120, right: cellSpace)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        cellSpace
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        cellSpace
    }
}

extension FavouriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectCell(indexPath: indexPath)
    }
}
