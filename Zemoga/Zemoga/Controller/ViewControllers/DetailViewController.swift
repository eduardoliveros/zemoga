//
//  DetailViewController.swift
//  Zemoga
//
//  Created by Eduardo Oliveros Acosta on 3/8/19.
//  Copyright © 2019 Eduardo Oliveros Acosta. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    @IBAction func favoriteAction(_ sender: UIBarButtonItem) {
        post.isFavorite = true
        sender.image = UIImage(named: "star_p")
    }
    
    var post: Post!
    var user: User? {
        didSet {
            tableView.reloadData()
        }
    }
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        userRequest()
        commentsRequest()
    }
    
    func configureView() {
        if post.isFavorite {
            rightBarButton.image = UIImage(named: "star_p")
        }
    }
    func userRequest() {
        AFHTTPSessionManager().get(Urls.getUser + "/\(post.userId)",
                                   parameters: [:],
                                   progress: { _ in },
                                   success: { [weak self] _, response in
                                    guard let strongSelf = self else { return }
                                    strongSelf.didCompleteWithResponse(response, request: Request.getUser)
            },
                                   failure: { [weak self] _, error in
                                    guard let strongSelf = self else { return }
                                    strongSelf.didFailWithError(error, request: Request.getUser)
            }
        )
    }
    
    func commentsRequest() {
        AFHTTPSessionManager().get(Urls.getComment + "\(post.id)",
            parameters: [:],
            progress: { _ in },
            success: { [weak self] _, response in
                guard let strongSelf = self else { return }
                strongSelf.didCompleteWithResponse(response, request: Request.getComment)
            },
            failure: { [weak self] _, error in
                guard let strongSelf = self else { return }
                strongSelf.didFailWithError(error, request: Request.getComment)
            }
        )
    }
    
    func registerCells() {
        tableView.register(DescriptionTableViewCell.nib(), forCellReuseIdentifier: ViewIdentifier.detailTVC)
        tableView.register(CommentTableViewCell.nib(), forCellReuseIdentifier: ViewIdentifier.commentTVC)
        tableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: ViewIdentifier.userTVC)
    }
}

extension DetailViewController: RequestProtocol {
    func didCompleteWithResponse(_ response: Any?, request: Int) {
        switch request {
        case Request.getUser:
            guard let data = response as? [AnyHashable: Any] else {
                return
            }
            if let userInfo = User.userWithInfo(data) {
                let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
                do {
                    try context.save()
                    user = userInfo
                } catch {
                    //        TODO: Include Error Message
                }
            }
        case Request.getComment:
            guard let data = response as? [[AnyHashable: Any]] else {
                return
            }
            for commentInfo in data {
                if let comment = Comment.commentWithInfo(commentInfo) {
                    let context = ((UIApplication.shared.delegate) as! AppDelegate).managedObjectContext
                    do {
                        try context.save()
                        comments.append(comment)
                    } catch {
                        //        TODO: Include Error Message
                    }
                }
            }
            tableView.reloadData()
        default:
            break
        }
    }
    
    func didFailWithError(_ error: Error, request: Int) {
        //        TODO: Include Error Message
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if user != nil {
                return 2
            }
            return 1
        case 1:
            return comments.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        TODO: Create height constants
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 90
            } else {
                return 160
            }
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ViewIdentifier.detailTVC) as! DescriptionTableViewCell
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.descriptionLabel.text = post.body
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: ViewIdentifier.userTVC) as! UserTableViewCell
                cell.labelName.text = user?.name ?? ""
                cell.labelEmail.text = user?.email ?? ""
                cell.labelPhone.text = user?.phone ?? ""
                cell.labelWebsite.text = user?.website ?? ""
                return cell
            default:
                break
            }
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ViewIdentifier.commentTVC) as! CommentTableViewCell
            let comment = comments[indexPath.row]
            cell.bodyLabel.text = comment.body
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            //        TODO: Create view on XibFile
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
            let frame = CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 30)
            let label = UILabel(frame: frame)
            label.text = "COMMENTS"
            headerView.addSubview(label)
            headerView.backgroundColor = .lightGray
            return headerView
        default:
            return nil
        }
    }
}
