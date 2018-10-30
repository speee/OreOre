//
//  ViewController.swift
//  OreOre
//
//  Created by git on 08/07/2018.
//  Copyright (c) 2018 git. All rights reserved.
//

import UIKit
import Apollo

class ViewController: UIViewController {
  @IBOutlet weak var firstName: UILabel!
  @IBOutlet weak var lastName: UILabel!
  @IBOutlet weak var recentTitle: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()
      apollo.fetch(query: AuthorQuery(id: 1)) { (result, error) in
        self.firstName.text = result?.data?.author?.firstName ?? ""
        self.lastName.text = result?.data?.author?.lastName ?? ""
        self.recentTitle.text = result?.data?.author?.posts?.first??.title ?? ""
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

