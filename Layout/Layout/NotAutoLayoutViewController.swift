//
//  NotAutoLayoutViewController.swift
//  Layout
//
//  Created by 史　翔新 on 2017/06/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit
import NotAutoLayout

class LogoView: UIImageView {}
class SetmentedView: UISegmentedControl {}
class TextLabel: UITextView {}
class SeparatorView: UIView {}

class NotAutoLayoutViewController: UIViewController {
	
	var layoutStartDate = Date()
	
	fileprivate lazy var layoutView: LayoutView = {
		let view = LayoutView()
		view.backgroundColor = .white
		view.frame = UIScreen.main.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		return view
	}()
	
	fileprivate lazy var logo: UIView = {
		let image = #imageLiteral(resourceName: "logo.png")
		let view = LogoView(image: image)
//		view.transform = view.transform.rotated(by: .pi / 4)
		return view
	}()
	
	fileprivate lazy var segmented: UIView = {
		let segment = SetmentedView()
		segment.insertSegment(withTitle: "Intro", at: 0, animated: false)
		segment.insertSegment(withTitle: "1", at: 1, animated: false)
		segment.insertSegment(withTitle: "2", at: 2, animated: false)
//		segment.transform = segment.transform.rotated(by: .pi / 4)
		return segment
	}()
	
	fileprivate lazy var textLabel: UIView = {
		let view = TextLabel()
		view.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Consise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Consise syntax, readable & chainable."
		return view
	}()
	
	fileprivate lazy var separatorView: UIView = {
		let view = SeparatorView()
		view.backgroundColor = UIColor(red: 0.353,
		                               green: 0.667,
		                               blue: 0.953,
		                               alpha: 1.00)
		return view
	}()
	
	override func loadView() {
		let view = self.layoutView
		self.view = view
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		self.layoutStartDate = Date()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		print(-self.layoutStartDate.timeIntervalSinceNow)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.addLogo()
		self.addSegmented()
		self.addTextLabel()
		self.addSeparatorView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}

extension NotAutoLayoutViewController {
	
	func addLogo() {
		self.layoutView.nal.setupSubview(self.logo) { (wizard) in wizard
			.makeDefaultLayout { (maker) in maker
				.pinTopLeft(to: maker.parentView, s: .topLeft, offsetBy: CGVector(dx: 10, dy: 10))
				.setBottomRight(to: CGPoint(x: 110, y: 110))
			}
			.addToParent()
		}
	}
	
	func addSegmented() {
		self.layoutView.nal.setupSubview(self.segmented) { (wizard) in wizard
			.makeDefaultLayout({ (maker) in maker
				.pinTopLeft(to: self.logo, s: .topRight, offsetBy: CGVector(dx: 10, dy: 0))
				.pinRight(to: self.layoutView, s: .right, offsetBy: -10)
				.fitHeight(by: 0)
			})
			.addToParent()
		}
	}
	
	func addTextLabel() {
		self.layoutView.nal.setupSubview(self.textLabel) { (wizard) in wizard
			.makeDefaultLayout({ (maker) in maker
				.pinTopLeft(to: self.segmented, s: .bottomLeft)
				.pinRight(to: self.segmented, s: .right, ignoresTransform: true)
				.fitHeight(by: 0)
			})
			.addToParent()
		}
	}
	
	func addSeparatorView() {
		self.layoutView.nal.setupSubview(self.separatorView) { (wizard) in wizard
			.makeDefaultLayout({ (maker) in maker
				.pinTopRight(to: self.textLabel, s: .bottomRight, offsetBy: CGVector(dx: 0, dy: 10))
				.pinLeft(to: self.logo, s: .left, ignoresTransform: true)
				.setHeight(to: 2)
			})
			.addToParent()
		}
	}
	
}
