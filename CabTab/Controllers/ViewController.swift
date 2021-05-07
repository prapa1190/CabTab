//
//  ViewController.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.navigationBar.isHidden = false
	}
}

