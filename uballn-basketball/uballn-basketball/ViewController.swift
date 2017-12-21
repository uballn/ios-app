//
//  ViewController.swift
//  uballn-basketball
//
//  Created by Jeremy Gaston on 11/9/17.
//  Copyright © 2017 UBALLN. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    @IBOutlet var features: UIScrollView!
    @IBOutlet var paging: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Background video
        
        let URL = Bundle.main.url(forResource: "playing_ball", withExtension: "mp4")
        
        Player = AVPlayer.init(url: URL!)
        
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PlayerLayer.frame = view.layer.frame
        
        Player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd (notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
        
        // Onboarding sets
        
        features.delegate = self
        let slides:[onboardingView] = createSlides()
        loadFeatures(slides: slides)
        paging.numberOfPages = slides.count
        paging.currentPage = 0
        view.bringSubview(toFront: paging)
        
    }

    @objc func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to: kCMTimeZero)
    }
    
    @IBAction func unwindToLanding(segue:UIStoryboardSegue) {
    }
    
    // Functions
    
    func createSlides() -> [onboardingView] {
        let slide1:onboardingView = Bundle.main.loadNibNamed("onboarding", owner: self, options: nil)?.first as! onboardingView
        slide1.headerText.text = "Set Up"
        slide1.bodyText.text = "Create a player profile to show hoopers what you bring to the court. "
        
        let slide2:onboardingView = Bundle.main.loadNibNamed("onboarding", owner: self, options: nil)?.first as! onboardingView
        slide2.headerText.text = "Invite"
        slide2.bodyText.text = "Make sure your friends know where to find the best pickup games."
        
        let slide3:onboardingView = Bundle.main.loadNibNamed("onboarding", owner: self, options: nil)?.first as! onboardingView
        slide3.headerText.text = "Play Now"
        slide3.bodyText.text = "If you're ready to hoop, like RIGHT NOW, it's just a tap away."
        
        let slide4:onboardingView = Bundle.main.loadNibNamed("onboarding", owner: self, options: nil)?.first as! onboardingView
        slide4.headerText.text = "Earn"
        slide4.bodyText.text = "Collect tokens every time you play, and earn some sweet rewards."
        
        return [slide1, slide2, slide3, slide4]
    }
    
    func loadFeatures(slides: [onboardingView]) {
        features.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        features.contentSize = CGSize(width: view.frame.width * CGFloat (slides.count), height: view.frame.height)
        features.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            features.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        paging.currentPage = Int(pageIndex)
    }

}

