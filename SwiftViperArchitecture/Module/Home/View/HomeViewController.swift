import SnapKit
import UIKit

final class HomeViewController: UIViewController {
    private let labelTitle: UILabel = .init()
    private let homeTableViewController: UITableView = .init()
    let indicator = UIActivityIndicatorView(style: .medium)
         
    let cont = UIView()
    let back = UIView()
    private var itemCats: [CatEntity] = []

    lazy var presenter: HomePresenter = .init(interactor: HomeInteractor(), view: self )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(back)
        makeUICordinate()
        presenter.viewDidLoad()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cats \(itemCats[indexPath.row].description )"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCats.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onTapCell(model: itemCats[indexPath.row])
    }
}

extension HomeViewController: HomeViewInputs {
    func reloadTableView(cats: [CatEntity]) {
        itemCats = cats
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.homeTableViewController.reloadData()
        }
    }

    func configure() {}

    func setupTableViewCell() {}

    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in

            guard let self = self else { return }
            animate ? self.indicator.startAnimating() : self.indicator.stopAnimating()
            self.indicator.isHidden = !animate
        }
    }

    func sortByTitle() {}
}

// MARK: UI Draw

extension HomeViewController {
    func makeUICordinate() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        labelTitle.text = "HTTP CATS"
        labelTitle.textColor = .white
        labelTitle.textAlignment = .center
        back.backgroundColor = .white
        indicator.color = .black
        indicator.isHidden = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        cont.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cont.layer.cornerRadius = 30
        cont.backgroundColor = .red
        cont.addSubview(labelTitle)
        back.addSubview(cont)
        back.addSubview(homeTableViewController)
        back.addSubview(indicator)
        
       
    back.snp.makeConstraints{make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenHeight)
        }
       cont.snp.makeConstraints { make in
      
                   make.top.equalTo(self.back.snp.top)
                   make.height.equalTo(75)
                   make.width.equalTo(screenWidth)
               }

               // Center the labelTitle within the cont view
 labelTitle.snp.makeConstraints { make in
                   make.centerX.equalTo(cont.snp.centerX)
                   make.top.equalTo(cont.snp.top).offset(10)
               }

        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
               }
        homeTableViewController.snp.makeConstraints { make in
                       make.top.equalTo(self.cont.snp.bottom).offset(20)
                       make.left.equalTo(self.view).offset(20)
                       make.right.equalTo(self.view).offset(-20)
                       make.bottom.equalTo(self.view)
              
                   }
     
       

        homeTableViewController.dataSource = self
        homeTableViewController.delegate = self
    }
}

/*extension HomeViewController: UINetworkInput {
    func presentAlert(controller: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(controller, animated: true)
        }
    }
}*/
