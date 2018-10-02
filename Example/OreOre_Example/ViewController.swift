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

    override func viewDidLoad() {
        super.viewDidLoad()
      apollo.fetch(query: AuthorQuery(id: 1)) { (result, error) in
        print(result?.data?.author?.firstName)
        print(result?.data?.author?.lastName)
        print(result?.data?.author?.posts)
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

