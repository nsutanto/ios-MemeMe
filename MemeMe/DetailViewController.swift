//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Nicholas Sutanto on 8/20/17.
//  Copyright © 2017 Nicholas Sutanto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var sentMemedImage : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = sentMemedImage.memedImage
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailToEdit" {
            let editVC = segue.destination as! EditMemeViewController
            editVC.originalImage = sentMemedImage.image
            
        }
    }
    
    @IBAction func performEdit(_ sender: Any) {
        performSegue(withIdentifier: "detailToEdit", sender: self)
        
    }
    @IBAction func performCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
