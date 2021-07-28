import UIKit
import CoreData

class AnimationTestViewController: UIViewController, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var fetchController: NSFetchedResultsController<BookDTO>!
    
    private lazy var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "cell")
        loadSavedData()
    }
    
    private func loadSavedData() {
        if fetchController == nil {
            let request: NSFetchRequest<BookDTO> = BookDTO.fetchRequest()
            let sort = NSSortDescriptor(key: "id", ascending: false)
            request.sortDescriptors = [sort]
            fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchController.delegate = self
        }
        
        do {
            try fetchController.performFetch()
            tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
}

extension AnimationTestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let book = fetchController?.object(at: indexPath) else {
            fatalError("Attempt to configure cell without a managed object")
        }
        cell.textLabel?.text = book.info?.title
        return cell
    }
    
    
    
}
