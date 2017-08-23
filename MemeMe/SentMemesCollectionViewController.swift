//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Nicholas Sutanto on 8/16/17.
//  Copyright © 2017 Nicholas Sutanto. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    var memes = [Meme]()
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        collectionView?.reloadData()
        tabBarController?.tabBar.isHidden = false
        
        initLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let memeImage = memes[(indexPath as NSIndexPath).row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemedCollectionViewCell", for: indexPath) as! CollectionViewCustomCell
        
        cell.memedImage?.image = memeImage.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewControllerID") as! DetailViewController
        
        //Populate view controller with data from the selected item
        detailController.sentMemedImage = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    func initLayout() {
        let space : CGFloat = 1
        var height : CGFloat!
        var width : CGFloat!
        var numberOfPictures : CGFloat!
    
        if UIDevice.current.orientation.isLandscape {
            numberOfPictures = 4
        } else {
            numberOfPictures = 3
        }
        width = (view.frame.size.width / numberOfPictures) - space
        height = width

        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = (view.frame.size.width - (numberOfPictures * width)) / (numberOfPictures - 1)
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

}
