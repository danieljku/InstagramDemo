//
//  HomeViewController.swift
//  InstagramDemo
//
//  Created by Daniel Ku on 2/24/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let postQuery = PFQuery(className: "Post")
    var photoTakingHelper: PhotoHelper?
    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        getPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getPosts()

        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func getPosts(){
        postQuery.order(byDescending: "createdAt")
        postQuery.includeKey("author")
        postQuery.limit = 20
        postQuery.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil{
                if let objects = objects{
                    self.posts = objects
                    self.tableView.reloadData()
                }
            }else{
                print(error!.localizedDescription)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func takePhoto(){
        photoTakingHelper = PhotoHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
            let instagramVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editVC") as! CaptionViewController
            instagramVC.imageToPost = image!
            self.present(instagramVC, animated: true, completion: nil)
        })
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath) as! PostsTableViewCell
        let post = posts[indexPath.row]
        
        cell.post = post
        
        return cell
    }
    

}

extension HomeViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is CameraViewController{
            takePhoto()
            return false
        }else{
            return true
        }
    }
}
