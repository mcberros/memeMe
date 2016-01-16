//
//  MemeDetailViewController.swift
//  memePickingImages
//
//  Created by Carmen Berros on 16/01/16.
//  Copyright © 2016 mcberros. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {


    @IBOutlet weak var memeImageView: UIImageView!

    var meme: Meme!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImageView!.image = meme.memedImage
        self.tabBarController?.tabBar.hidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}
