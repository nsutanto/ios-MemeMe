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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createMeme(_ sender: Any) {
        performSegue(withIdentifier: "segueCreateMeme", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "segueShowResult" {
        //    let vc = segue.destination as! ResultViewController
        //    vc.userChoice = getUserShape(sender as! UIButton)
        //}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
