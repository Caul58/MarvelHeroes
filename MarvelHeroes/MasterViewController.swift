//
//  MasterViewController.swift
//  MarvelHeroes
//
//  Created by CARLOS RAUL PEREZ MORENO on 9/8/17.
//  Copyright © 2017 CARLOS RAUL PEREZ MORENO. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Hero]()
    var shownObjects = [Hero]()
    fileprivate let bag = DisposeBag()
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Marvel Heroes"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.configureRefreshControl()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.refresh()
        self.configureSearchBar()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = shownObjects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let hero: Hero = shownObjects[indexPath.row]
        cell.textLabel?.text = hero.name
        cell.detailTextLabel?.text = hero.aka
        cell.imageView?.kf.setImage(with: hero.photoURL, placeholder: UIImage(named: "blank-avatar"))
        return cell
    }

    // MARK: - Refresh Control
    
    func configureRefreshControl(){
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        
        refreshControl.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }

    func configureSearchBar(){
        
        self.searchBar
            .rx
            .text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe( onNext:{ [weak self] (query) in
                if query == ""{
                    self?.shownObjects = (self?.objects)!
                }else{
                    self?.shownObjects = (self?.objects.filter { $0.name.contains(query!) })!
                }
                self?.tableView.reloadData()
            })
            .disposed(by: self.bag)
        
    }
    
    func refresh(){
        
        HeroesRequestManager.fetchHeroes(bag: bag, completion: { [weak self] heroesArray in
            self?.objects = heroesArray
            self?.shownObjects = heroesArray
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        })
        
    }
}

