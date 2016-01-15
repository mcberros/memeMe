//
//  SentMemesTableViewController.swift
//  memePickingImages
//
//  Created by Carmen Berros on 15/01/16.
//  Copyright © 2016 mcberros. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableView {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeTableCell")!
        let sentMeme = memes[indexPath.row]

        cell.textLabel?.text = sentMeme.topText
        cell.imageView?.image = sentMeme.memedImage
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

}