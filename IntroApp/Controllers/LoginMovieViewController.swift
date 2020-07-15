//
//  LoginMovieViewController.swift
//  IntroApp
//
//  Created by 伊藤和也 on 2020/07/14.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import AVFoundation

class LoginMovieViewController: UIViewController {
    
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Movie Player Layer
        let path = Bundle.main.path(forResource: "start",
                                    ofType: "mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //Make AVPlayer Layer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0,
                                   y: 0,
                                   width: view.frame.size.width,
                                   height: view.frame.size.height)
        playerLayer.videoGravity = .resizeAspectFill
        
        //無限ループ処理
        playerLayer.repeatCount = 0
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer,
                                  at: 0)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem,
                                               queue: .main) {
                                                (complate) in
                                                
                                                self.player.seek(to: .zero)
                                                self.player.play()
                                                
        }
        //動画の再生
        self.player.play()
        
    }
    
    //Navigation Bar Hide
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func loginAction(_ sender: Any) {
        self.player.pause()
    }
    
}
