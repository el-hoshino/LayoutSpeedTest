//
//  AutoLayoutViewController.swift
//  Layout
//
//  Created by 史　翔新 on 2017/06/15.
//  Copyright © 2017年 Crazism. All rights reserved.
//

import UIKit

class AutoLayoutViewController: UIViewController {

	var layoutStartDate = Date()
	
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
