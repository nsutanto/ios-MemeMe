//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Nicholas Sutanto on 8/20/17.
//  Copyright © 2017 Nicholas Sutanto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var memedImage : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = memedImage.memedImage
    }
    @IBAction func performCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
