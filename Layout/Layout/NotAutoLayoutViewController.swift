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
	
	fileprivate lazy var notAutoLayoutView: NotAutoLayoutView = {
		let view = NotAutoLayoutView()
		view.backgroundColor = .white
		view.frame = UIScreen.main.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		return view
	}()
	
	override func loadView() {
		let view = self.notAutoLayoutView
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
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}

class NotAutoLayoutView: UIView {
	
	let logo: UIView = {
		let image = #imageLiteral(resourceName: "logo.png")
		let view = UIImageView(image: image)
		return view
	}()
	
	let segmented: UIView = {
		let segment = UISegmentedControl()
		segment.insertSegment(withTitle: "Intro", at: 0, animated: false)
		segment.insertSegment(withTitle: "1", at: 1, animated: false)
		segment.insertSegment(withTitle: "2", at: 2, animated: false)
		return segment
	}()
	
	let textLabel: UIView = {
		let view = UITextView()
		view.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Consise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Consise syntax, readable & chainable."
		return view
	}()
	
	let separatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 0.353,
		                               green: 0.667,
		                               blue: 0.953,
		                               alpha: 1.00)
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		self.addSubview(self.logo)
		self.addSubview(self.segmented)
		self.addSubview(self.textLabel)
		self.addSubview(self.separatorView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.layoutLogo()
		self.layoutSegmented()
		self.layoutTextLabel()
		self.layoutSeparatorView()
	}
	
}

extension NotAutoLayoutView {
	
	private func layoutLogo() {
		self.nal.place(self.logo) { $0
			.pinTopLeft(to: $0.parentView, s: .topLeft, offsetBy: CGVector(dx: 10, dy: 10))
			.setBottomRight(to: CGPoint(x: 110, y: 110))
		}
	}
	
	private func layoutSegmented() {
		self.nal.place(self.segmented) { $0
			.pinTopLeft(to: self.logo, s: .topRight, offsetBy: CGVector(dx: 10, dy: 0))
			.pinRight(to: $0.parentView, s: .right, offsetBy: -10)
			.fitHeight(by: 0)
		}
	}
	
	private func layoutTextLabel() {
		self.nal.place(self.textLabel) { $0
			.pinTopLeft(to: self.segmented, s: .bottomLeft)
			.pinRight(to: self.segmented, s: .right, ignoresTransform: true)
			.fitHeight(by: 0)
		}
	}
	
	private func layoutSeparatorView() {
		self.nal.place(self.separatorView) { $0
			.pinTopRight(to: self.textLabel, s: .bottomRight, offsetBy: CGVector(dx: 0, dy: 10))
			.pinLeft(to: self.logo, s: .left, ignoresTransform: true)
			.setHeight(to: 2)
		}
	}
	
}
