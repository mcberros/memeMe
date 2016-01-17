//
//  SentMemesCollectionViewController.swift
//  memePickingImages
//
//  Created by Carmen Berros on 16/01/16.
//  Copyright © 2016 mcberros. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    private var memes = [Meme]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes

        collectionView!.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemeCollectionCell", forIndexPath: indexPath) as! SentMemesCollectionViewCell

        let sentMeme = memes[indexPath.item]

        cell.sentMemeImageView?.image = sentMeme.memedImage
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController

        detailController.meme = self.memes[indexPath.item]

        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
