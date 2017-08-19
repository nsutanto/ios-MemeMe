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

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Implement to push the next story node.
        //let nextStoryNode = storyNode.storyNodeForIndex(index: (indexPath as NSIndexPath).row)
        //let controller = self.storyboard!.instantiateViewController(withIdentifier: "StoryNodeViewController") as! StoryNodeViewController
        //controller.storyNode = nextStoryNode
        //self.navigationController!.pushViewController(controller, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let memeImage = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCustomCell") as! TableCustomCell
        
        
        cell.memeImage!.image = memeImage.memedImage
        cell.memeText!.text = "\(memeImage.topText) ... \(memeImage.bottomText)"

        
        return cell
        
        
        //cell.textLabel!.text = storyNode.promptForIndex((indexPath as NSIndexPath).row)
        
        
        //return cell
        
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")!
        //let adventure = adventures[(indexPath as NSIndexPath).row]
        //cell.textLabel!.text = adventure.credits.title
        //cell.detailTextLabel!.text = adventure.credits.author
        //let imageName = adventure.credits.imageName
        //cell.imageView!.image = UIImage(named: imageName!)
    }

}
