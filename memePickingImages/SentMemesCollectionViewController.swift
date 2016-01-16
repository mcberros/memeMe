//
//  SentMemesCollectionViewController.swift
//  memePickingImages
//
//  Created by Carmen Berros on 16/01/16.
//  Copyright © 2016 mcberros. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {

    var memes = [Meme]()

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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SentMemesCollectionViewCell", forIndexPath: indexPath)

        let sentMeme = memes[indexPath.row]

        cell.sentMemesCollectionViewCell?.image = sentMeme.memedImage
        return cell
    }
}
