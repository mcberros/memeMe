//
//  SentMemesTableViewController.swift
//  memePickingImages
//
//  Created by Carmen Berros on 15/01/16.
//  Copyright © 2016 mcberros. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {

    var memes = [Meme]()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes

        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeTableCell")!

        let sentMeme = memes[indexPath.row]

        cell.textLabel?.text = sentMeme.topText
        cell.imageView?.image = sentMeme.memedImage
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController

        detailController.meme = self.memes[indexPath.row]

        self.navigationController!.pushViewController(detailController, animated: true)

    }

}