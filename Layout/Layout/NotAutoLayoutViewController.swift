//
//  NotAutoLayoutViewController.swift
//  Layout
//
//  Created by 史　翔新 on 2017/06/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit
import NotAutoLayout

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
		let view = UIImageView(image: image)
		return view
	}()
	
	fileprivate lazy var segmented: UIView = {
		let segment = UISegmentedControl()
		segment.insertSegment(withTitle: "Intro", at: 0, animated: false)
		segment.insertSegment(withTitle: "1", at: 1, animated: false)
		segment.insertSegment(withTitle: "2", at: 2, animated: false)
		return segment
	}()
	
	fileprivate lazy var textLabel: UIView = {
		let view = UITextView()
		view.text = "Swift manual views layouting without auto layout, no magic, pure code, full control. Consise syntax, readable & chainable.\n\nSwift manual views layouting without auto layout, no magic, pure code, full control. Consise syntax, readable & chainable."
		return view
	}()
	
	fileprivate lazy var separatorView: UIView = {
		let view = UIView()
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
		let layout = Layout.makeAbsolute(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
		self.layoutView.addSubview(self.logo, constantLayout: layout)
	}
	
	func addSegmented() {
		let layout = Layout.makeCustome(thatFits: .zero) { [unowned logo] (fittedSize, boundSize) -> Frame in
			let frame = Frame(x: logo.frame.maxX + 10, from: .left,
			                  y: logo.frame.minY, from: .top,
			                  width: boundSize.width - logo.frame.maxX - 10 - 10,
			                  height: fittedSize.height)
			return frame
		}
		self.layoutView.addSubview(self.segmented, constantLayout: layout)
	}
	
	func addTextLabel() {
		let layout = Layout.makeCustome(thatFits: { [unowned segmented] _ in CGSize(width: segmented.bounds.width, height: 0) }) { [unowned segmented] (fittedSize, boundSize) -> Frame in
			let frame = Frame(x: segmented.frame.minX, from: .left,
			                  y: segmented.frame.maxY + 10, from: .top,
			                  width: fittedSize.width,
			                  height: fittedSize.height)
			return frame
		}
		self.layoutView.addSubview(self.textLabel, constantLayout: layout)
	}
	
	func addSeparatorView() {
		let layout = Layout.makeCustom { [unowned logo, unowned textLabel] (boundSize) -> Frame in
			let frame = Frame(x: 0, from: .center,
			                  y: max(logo.frame.maxY, textLabel.frame.maxY) + 10, from: .top,
			                  width: boundSize.width - 20,
			                  height: 2)
			return frame
		}
		self.layoutView.addSubview(self.separatorView, constantLayout: layout)
	}
	
}
