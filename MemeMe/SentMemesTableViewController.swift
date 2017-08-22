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
    var deleteMemeIndexPath: IndexPath? = nil
    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            deleteMemeIndexPath = indexPath
            let meme = memes[indexPath.row]
            confirmDelete(meme)
        }
    }
    
    func confirmDelete(_ meme: Meme) {
        let alert = UIAlertController(title: "Delete Image", message: "Are you sure you want to permanently delete?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteMeme)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: handleCancelDelete)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        //alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteMeme(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteMemeIndexPath {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            memes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func handleCancelDelete(alertAction: UIAlertAction!) {
        deleteMemeIndexPath = nil
    }


}
