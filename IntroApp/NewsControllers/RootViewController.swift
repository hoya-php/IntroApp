//
//  RootViewController.swift
//  IntroApp
//
//  Created by 伊藤和也 on 2020/07/14.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import SegementSlide

class RootViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSelectedIndex = 0
        reloadData()
        
    }
    
    override func segementSlideHeaderView() -> UIView? {
        
        let headerView = UIImageView()
        
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerHeight: CGFloat
        
        if #available(iOS 11.0, *){
        headerHeight = view.bounds.height / 4 + view.safeAreaInsets.top
        } else {
        headerHeight = view.bounds.height / 4 + topLayoutGuide.length
        }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        return headerView
        
    }
    
    override var titlesInSwitcher: [String] {
        return ["TOP",
                "Abema",
                "Yahoo!!",
                "IT",
                "Buzz",
                "CNN"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
            case 0:
                return TopTableViewController()
            
            case 1:
                return AbemaNewsTableViewController()
            
            case 2:
                return YahooNewsTableViewController()
            
            case 3:
                return ITNewsTableViewController()
            
            case 4:
                return BuzzNewsTableViewController()
            
            case 5:
                return CNNNewsTableViewController()
            
            default: return TopTableViewController()
            
        }
        
    }
    
}
