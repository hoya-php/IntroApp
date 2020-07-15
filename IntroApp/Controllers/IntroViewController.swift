//
//  IntroViewController.swift
//  IntroApp
//
//  Created by 伊藤和也 on 2020/07/14.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import Lottie

class IntroViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    
    var onBoardArray = ["1",
                       "2",
                       "3",
                       "4",
                       "5"]
    
    var onBoardStringArray = ["私たちは完璧です。",
                              "美しさと感動と",
                              "操作するユーザーに与えます。",
                              "考えることはしない。",
                              "さぁ、試してみよう。"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView.isPagingEnabled = true
        setUpScrollView()
        
        
        for i in 0...4 {
            //set lottie framework animation
            let animationView = AnimationView()
            let animation = Animation.named(onBoardArray[i])
            
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width,
                                         y: 0,
                                         width: view.frame.size.width,
                                         height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            
            scrollView.addSubview(animationView)
            
        }

    }
    
    
    //setUp ScrollView 各ScrollView にラベルを貼り付ける。
    func setUpScrollView() {
        
        scrollView.delegate = self
        
        //ScrollView width * 5 で５ページ分のViewを作成する。
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5,
                                        height: scrollView.frame.size.height)
        
        for i in 0...4 {
            
            let onloadLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width,
                                                    y: view.frame.size.height / 3,
                                                    width: scrollView.frame.size.width,
                                                    height: scrollView.frame.size.height))
            
            onloadLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            onloadLabel.textAlignment = .center
            onloadLabel.text = onBoardStringArray[i]
            scrollView.addSubview(onloadLabel)
            
        }
    }
    
    //Navigation Bar Hide
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
