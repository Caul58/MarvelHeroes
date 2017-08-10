//
//  DetailViewController.swift
//  MarvelHeroes
//
//  Created by CARLOS RAUL PEREZ MORENO on 9/8/17.
//  Copyright © 2017 CARLOS RAUL PEREZ MORENO. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var photoImage: UIImageView!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            title = detail.name
            if let textView = infoTextView {
                textView.text = "Real Name: \(detail.aka) \nHeight: \(detail.height)\nPower: \n\(detail.power)\nAbilities:\n\(detail.abilities)\nGroups: \n\(detail.groups)"
            }
            if let imageView = photoImage {
                imageView.kf.setImage(with: detail.photoURL, placeholder: UIImage(named: "blank-avatar"))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Hero! {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool{
        return false
    }

}

