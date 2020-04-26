//
//	SemiCatmullRomViewController.swift
//	BezierTest2
//
//	Created by Kaz Yoshikawa on 4/25/20.
//	Copyright © 2020 Kaz Yoshikawa. All rights reserved.
//

import UIKit

class SemiCatmullRomViewController: UIViewController {

	@IBOutlet weak var closeSwitch: UISwitch!
	@IBOutlet weak var clearButtonItem: UIBarButtonItem!
	@IBOutlet weak var bezierView: SemiCatmullRomView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@IBAction func closeAction(_ sender: UISwitch) {
		self.bezierView.close = !self.bezierView.close
	}
	
	@IBAction func clearAction(_ sender: UIBarButtonItem) {
		self.bezierView.clear()
	}
}

