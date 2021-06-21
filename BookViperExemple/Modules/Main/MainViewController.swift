import UIKit
import Nuke

final class MainViewController: UIViewController {
    private let identifierCell = "book"
    private var presenter: MainPresenterProtocol!
    private var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.searchBooks(search: "детские сказки")
        configure()
    }
    
    func setPresenter(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func configure() {
        let spacing: CGFloat = 30
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(0.8)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.39)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(60))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        let layout = UICollectionViewCompositionalLayout(section: section)
         
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.rightAnchor.constraint(equalTo: view.rightAnchor),
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collection.contentInset = .init(top: spacing, left: 0, bottom: spacing, right: 0)
        
        collection.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: BookCollectionViewCell.self)
        )
        collection.register(
            HeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: HeaderCollectionReusableView.self)
        )
    }

}

extension MainViewController: MainViewProtocol {
    func showBooks(books: [Book]) {
        collection.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.getSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getCellCount(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: HeaderCollectionReusableView.self),
            for: indexPath
        ) as! HeaderCollectionReusableView
        header.setTitle(text: presenter.getSectionTitle(at: indexPath.section))
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BookCollectionViewCell.self),
            for: indexPath
        ) as! BookCollectionViewCell
        let data = presenter.getCellData(indexPath: indexPath)
        let emptyImage = UIImage(named: "emptyImage")
        if let urlString = data.info.imageLinks?.normal, let url = URL(string: urlString) {
            let options = ImageLoadingOptions(placeholder: emptyImage, failureImage: emptyImage)
            Nuke.loadImage(with: url, options: options, into: cell.imageView)
        } else {
            cell.imageView.image = emptyImage
        }
        return cell
    }
    
}
