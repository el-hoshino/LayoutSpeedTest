//
//  CodeLayoutViewController.swift
//  Layout
//
//  Created by 史　翔新 on 2017/06/14.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit

class CodeLayoutViewController: UIViewController {
	
	var layoutStartDate = Date()
	
	private lazy var codeLayoutView: CodeLayoutView = {
		let view = CodeLayoutView()
		return view
	}()
	
	override func loadView() {
		let view = self.codeLayoutView
		view.frame = UIScreen.main.bounds
		view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class CodeLayoutView: UIView {
	
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
		
		self.logo.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
		self.segmented.frame = CGRect(x: self.logo.frame.maxX + 10, y: self.logo.frame.minY, width: self.bounds.width - self.logo.frame.maxX - 10 - 10, height: 0)
		self.segmented.frame.size.height = self.segmented.sizeThatFits(self.segmented.frame.size).height
		self.textLabel.frame = CGRect(x: self.logo.frame.maxX + 10, y: self.segmented.frame.maxY + 10, width: self.segmented.frame.width, height: 0)
		self.textLabel.sizeToFit()
		self.separatorView.frame = CGRect(x: 10, y: self.textLabel.frame.maxY + 10, width: self.bounds.width - 10 - 10, height: 2)
		
	}
	
}
