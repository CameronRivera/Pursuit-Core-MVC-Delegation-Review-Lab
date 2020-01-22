//
//  ViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Benjamin Stone on 8/19/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class movieViewController: UIViewController {

    // MARK: Outlets of movieViewController
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    // MARK: Properties of movieViewController
    var movies: [Movie] = []
    var fontSize: Double = 17.0 {
        didSet{
            tableView.reloadData()
        }
    }
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        tableView.dataSource = self
    }
    
    // MARK: Helper Methods
    private func setUp(){
        movies = Movie.allMovies
        settingsButton.title = "Settings"
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIBarButtonItem){
        let newStoryboard = UIStoryboard(name: "SecondStoryboard", bundle: nil)
        let fontAdjustVCReference = newStoryboard.instantiateViewController(withIdentifier: "adjustFontViewController") as! AdjustFontViewController
        fontAdjustVCReference.initialFont = Double(fontSize)
        fontAdjustVCReference.delegate = self
        navigationController?.pushViewController(fontAdjustVCReference, animated: true)
    }
    
}

// MARK: DataSource Methods
extension movieViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let xCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        xCell.textLabel?.text = movies[indexPath.row].name
        xCell.textLabel?.font = UIFont(name: "Avenir", size: CGFloat(fontSize))
        xCell.detailTextLabel?.text = movies[indexPath.row].year.description
        xCell.detailTextLabel?.font = UIFont(name: "Avenir", size: CGFloat(fontSize))
        
        return xCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}

// MARK: AdjustFontViewControllerDelegate Methods
extension movieViewController: AdjustFontViewControllerDelegate{
    
    func fontSizeAdjusted(_ AdjustFontViewController: AdjustFontViewController) {
        self.fontSize = AdjustFontViewController.fontSize
    }
    
}
