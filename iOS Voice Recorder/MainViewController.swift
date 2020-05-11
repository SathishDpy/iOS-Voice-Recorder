//
//  ViewController.swift
//  iOS Voice Recorder
//
//  Created by Sathish Kumar on 11/05/20.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var startOrStopButton: UIButton!
  var isRecording = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func startOrStopButtonClicked(_ sender: UIButton) {
    isRecording = !isRecording
    if isRecording {
      sender.setTitle("Recording/Stop", for: .normal)
    } else {
      sender.setTitle("Start", for: .normal)
    }
  }
}
