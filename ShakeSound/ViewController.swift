//
//  ViewController.swift
//  ShakeSound
//
//  Created by Watcha Pon on 2/15/17.
//  Copyright © 2017 Indie Co. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var soundFiles = ["boing","explosion","hit","knife","shoot","swish","wah","warble"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    func randomSound(){
//        guard let path = Bundle.main.url(forResource: "hit", withExtension: "mp3") else {
        let randomSound = Int(arc4random_uniform(UInt32(soundFiles.count)))
        guard let path = NSDataAsset(name: soundFiles[randomSound]) else {
            print("Path not Found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
//            audioPlayer = try AVAudioPlayer(contentsOf: path, fileTypeHint: AVFileTypeMPEGLayer3 )
            audioPlayer = try AVAudioPlayer(data: path.data, fileTypeHint: AVFileTypeMPEGLayer3)
            audioPlayer.play()
        } catch let error as NSError{
        print("error : \(error.localizedDescription)")
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            randomSound()
        }
    }

}

