//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Nicholas Sutanto on 8/16/17.
//  Copyright © 2017 Nicholas Sutanto. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    var memes = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewControllerID") as! DetailViewController
        
        //Populate view controller with data from the selected item
        detailController.memedImage = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memeImage = memes[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemedTableCustomCell", for: indexPath) as! TableCustomCell
        
        cell.memeImage?.image = memeImage.memedImage
        cell.memeText?.text = memeImage.topText! + "..." + memeImage.bottomText!
       
        return cell
    }

}
