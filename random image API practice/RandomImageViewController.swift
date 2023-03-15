//
//  RandomImageViewController.swift
//  random image API practice
//
//  Created by Ryan Lin on 2023/3/14.
//

import UIKit

class RandomImageViewController: UIViewController {
    
    var firstOptions = ["cat", "ocean", "sky", "people", "moon", "leaf", "flower"]
    var secondOptions = [String]()
    var firstOption = ""
    var secondOption = ""
    
    @IBOutlet weak var processIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var optionTextField: UITextField!
    @IBOutlet var optionPickerView: UIPickerView!
    @IBOutlet var optionToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionPickerView.delegate = self
        optionPickerView.dataSource = self
        
        optionTextField.inputView = optionPickerView
        optionTextField.inputAccessoryView = optionToolBar
        
        tapToSelect()
        configuration()
    }
    
    func fetchImage() {
        processIndicator.startAnimating()
        optionTextField.isHidden = true
        pictureImageView.image = UIImage(systemName: "sailboat")
        if let randomURL = URL(string: "https://loremflickr.com/350/400/\(firstOption),\(secondOption)/all") {
            print(randomURL.description)
            URLSession.shared.dataTask(with: randomURL) { data, response, error in
                if let data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        
                        self.pictureImageView.image = image
                        self.pictureImageView.contentMode = .scaleAspectFill
                        self.processIndicator.stopAnimating()
                    }
                }
            }.resume()
        }
    }
    
    func tapToSelect() {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 2
        tap.addTarget(self, action: #selector(showPickerVier))
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(tap)
        
    }
    
    @objc func showPickerVier() {
        optionTextField.becomeFirstResponder()
        optionTextField.isHidden = true
    }
    
    @IBAction func chosenCancelBarItem(_ sender: Any) {
        view.endEditing(true)
        pictureImageView.image = UIImage(systemName: "photo")
        pictureImageView.contentMode = .scaleAspectFit
        optionTextField.isHidden = false
    }
    
    
    @IBAction func getImageBarItem(_ sender: Any) {
        fetchImage()
    }
    
    func configuration() {
        pictureImageView.image = UIImage(systemName: "photo")
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.tintColor = .systemGray5
        pictureImageView.layer.cornerRadius = 15
        
        //顯示未知進度
        processIndicator.color = .white
        processIndicator.hidesWhenStopped = true
    }
}
