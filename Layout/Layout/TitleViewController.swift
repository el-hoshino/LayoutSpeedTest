//
//  TitleViewController.swift
//  Layout
//
//  Created by 史　翔新 on 2017/06/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit
import NotAutoLayout

class TitleViewController: UIViewController {
	
	fileprivate lazy var layoutView: LayoutView = {
		let view = LayoutView()
		view.backgroundColor = .white
		return view
	}()
	
	override func loadView() {
		let view = self.layoutView
		view.frame = UIScreen.main.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view = view
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.addButton(title: "AutoLayout", tag: 1)
		self.addButton(title: "Code", tag: 2)
		self.addButton(title: "PinLayout", tag: 3)
		self.addButton(title: "NotAutoLayout", tag: 4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TitleViewController {
	
	func addButton(title: String, tag: Int) {
		
		let button = UIButton()
		button.setTitleColor(.black, for: .normal)
		button.setTitle(title, for: .normal)
		button.tag = tag
		button.layer.borderWidth = 2
		button.layer.borderColor = UIColor.blue.cgColor
		button.layer.cornerRadius = 10
		button.addTarget(self, action: #selector(self.onButtonTapped(button:)), for: .touchUpInside)
		
		self.layoutView.nal.setupSubview(button) { (wizard) in wizard
			.makeDefaultLayout({ (maker) in maker
				.pinTopCenter(to: maker.parentView, s: .topCenter)
				.setSize(to: CGSize(width: 200, height: 50))
				.movingY(by: CGFloat(tag - 1) * (20 + 50) + 20)
			})
			.addToParent()
		}
		
	}
	
}

extension TitleViewController {
	
	enum Controller {
		case autoLayout
		case code
		case pinLayout
		case notAutoLayout
		
		var controller: UIViewController {
			switch self {
			case .autoLayout:
				let storyboard = UIStoryboard(name: "AutoLayout", bundle: nil)
				let controller = storyboard.instantiateViewController(withIdentifier: "main")
				return controller
				
			case .code:
				return CodeLayoutViewController()
				
			case .pinLayout:
				return PinLayoutViewController()
				
			case .notAutoLayout:
				return NotAutoLayoutViewController()
			}
		}
	}
	
	func push(_ controller: Controller) {
		self.navigationController?.pushViewController(controller.controller, animated: true)
	}
	
}

extension TitleViewController {
	
	@objc func onButtonTapped(button: UIButton) {
		
		switch button.tag {
		case 1:
			self.push(.autoLayout)
			
		case 2:
			self.push(.code)
		
		case 3:
			self.push(.pinLayout)
			
		case 4:
			self.push(.notAutoLayout)
			
		default:
			break
		}
		
	}
	
}
