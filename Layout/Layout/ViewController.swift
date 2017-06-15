//
//  ViewController.swift
//  Layout
//
//  Created by 史　翔新 on 2017/06/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		let navigation = self.makeNavigationController()
		let title = self.makeTitleController()
		navigation.viewControllers = [title]
		self.present(navigation, animated: false, completion: nil)
	}
	
}

extension ViewController {
	
	func makeNavigationController() -> UINavigationController {
		let controller = NavigationController()
		controller.navigationBar.isTranslucent = false
		return controller
	}
	
	func makeTitleController() -> UIViewController {
		let controller = TitleViewController()
		return controller
	}
	
}

