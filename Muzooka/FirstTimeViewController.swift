//
//  FirstTimeViewController.swift
//  Muzooka
//
//  Created by Jennifer Duffey on 5/13/15.
//  Copyright (c) 2015 Jennifer Duffey. All rights reserved.
//

import UIKit

class FirstTimeViewController: MuzookaViewController, UIScrollViewDelegate
{
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var pageControl: UIPageControl!

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		NSUserDefaults.standardUserDefaults().setBool(true, forKey: Constants.FIRST_TIME_USE_SHOWN_KEY)
		
		self.pageControl.numberOfPages = TutorialSteps.steps.count
		
		for step in TutorialSteps.steps
		{
			var fsv = FirstStepView(frame: CGRect(x: self.view.frame.width * CGFloat(step.rawValue), y: 0, width: self.view.frame.width, height: self.scrollView.frame.height))
			fsv.step = step
			println("step: \(step.rawValue) text:\(step.stepText)")
			fsv.buttonRegister?.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
			fsv.buttonDismiss?.addTarget(self, action: "buttonClick:", forControlEvents: UIControlEvents.TouchUpInside)
			fsv.tag = (step.rawValue + 1)
			self.scrollView.addSubview(fsv)
		}
		
		self.scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(TutorialSteps.steps.count), height: self.scrollView.frame.height - Constants.SCROLL_PADDING)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func buttonClick(sender: UIButton)
	{
		self.dismissViewControllerAnimated(true, completion:
		{ () -> Void in
			if sender.tag == Constants.TAG_ACTION
			{
				self.navController?.showLoginScreen()
			}
		})
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	// MARK: ScrollView Delegate Methods
	func scrollViewDidEndDecelerating(scrollView: UIScrollView)
	{
		let pageWidth = self.view.frame.width
		let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
		
		self.pageControl.currentPage = page

		scrollView.setContentOffset(CGPoint(x: CGFloat(page) * pageWidth, y: 0), animated: true)
		
		//var fsv = scrollView.viewWithTag(page + 1) as! FirstStepView
		//		fsv.step = FirstSteps(rawValue: page)
		
		UIView.transitionWithView(self.imageView, duration: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations:
		{ () -> Void in
			self.imageView.image = UIImage(named: "first_time_use_bg_\(page)")
		})
		{ (Bool) -> Void in
			
		}
	}

}
