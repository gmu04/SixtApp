//
//  AnnotationDetailViewController.swift
//  SixtApp
//
//  Created by Gokhan Mutlu on 5.07.2021.
//

import UIKit

class AnnotationDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    var annotation:CarAnnotation! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = annotation.title
        carImageView.image = annotation.carPhoto
    }


    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
