//
//  ViewController.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import UIKit
import AFNetworking

class PostViewController: UIViewController {

    //    Constants:
    let nonReadPosts = 20
    //    Variables:
    var postsArray: [Post] = []
    var array: [Post] = Post.getAll() ?? []
    var reloadData: Bool = false
    //    Outlets:
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        postRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //  Helpers:
    func postRequest() {
        AFHTTPSessionManager().get(Urls.getPost,
                                   parameters: [:],
                                   progress: { _ in },
                                   success: { [weak self] _, response in
                                    guard let strongSelf = self else { return }
                                    strongSelf.didCompleteWithResponse(response, request: Request.getPost)
            },
                                   failure: { [weak self] _, error in
                                    guard let strongSelf = self else { return }
                                    strongSelf.didFailWithError(error, request: Request.getPost)
            }
        )
    }
    
    func registerCells() {
        tableView.register(PostTableViewCell.nib(), forCellReuseIdentifier: ViewIdentifier.postTVC)
    }
    
    //    Actions
    @IBAction func reloadData(_ sender: Any) {
        reloadData = true
        postRequest()
    }

    @IBAction func filterAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            array = postsArray
        case 1:
            array = Post.getFavorites() ?? []
        default:
            break
        }
        tableView.reloadData()
    }
}

extension PostViewController: RequestProtocol {
    func didCompleteWithResponse(_ response: Any?, request: Int) {
        guard let data = response as? [[AnyHashable: Any]] else {
            //        TODO: Include Error Message
            return
        }
        for postInfo in data {
            if let post = Post.postWithInfo(postInfo, reload: reloadData) {
                let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
                do {
                    try context.save()
                    if post.isActive {
                        postsArray.append(post)
                    }
                } catch {
                      //        TODO: Include Error Message
                }
            }
        }
        array = postsArray
        tableView.reloadData()
        //        TODO: Include Success Message
    }
    
    func didFailWithError(_ error: Error, request: Int) {
        //        TODO: Include Error Message
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ViewIdentifier.postTVC, for: indexPath) as! PostTableViewCell
        let post = array[indexPath.row]
        cell.detailLabel.text = post.body ?? ""
        if post.read {
            cell.unReadIndicator.isHidden = true
        }
        
        if post.isFavorite && indexPath.row < nonReadPosts {
            cell.starView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = array[indexPath.row]
        return getCellHeight(withPost: post)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = array[indexPath.row]
        let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
        
        post.read = true
        do {
            try context.save()
        } catch {
              //        TODO: Include Error Message
        }
        launchDetailView(withPost: post)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //        TODO: Create view on XibFile
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let button = UIButton(frame: frame)
        button.setTitle("Delete All", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(headerAction), for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    //    Helpers:
    func launchDetailView(withPost post: Post) {
        let detailViewController = ViewControllerFactory.instantiateDetailViewController()
        detailViewController.post = post
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func getCellHeight(withPost post: Post) -> CGFloat {
        let verticalMargins:  CGFloat = 20
        let labelMsn: UILabel = UILabel(frame: CGRect(x: 30, y: 0, width: self.view.frame.width - 60, height: CGFloat.greatestFiniteMagnitude))
        
        labelMsn.numberOfLines = 0
        labelMsn.lineBreakMode = NSLineBreakMode.byWordWrapping
        labelMsn.text = post.body ?? ""
        labelMsn.sizeToFit()
        return labelMsn.frame.height + verticalMargins
    }
    
    @objc func headerAction(sender: UIButton) {
        for post in array {
            post.isActive = false
            let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
            do {
                try context.save()
                guard let index = array.firstIndex(of: post) else {
                    //        TODO: Include Error Message
                    return
                }
                postsArray.remove(at: index)
                array = postsArray
            } catch {
                //        TODO: Include Error Message
            }
        }
        tableView.reloadData()
    }
}
