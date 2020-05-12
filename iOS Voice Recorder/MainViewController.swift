//
//  ViewController.swift
//  iOS Voice Recorder
//
//  Created by Sathish Kumar on 11/05/20.
//  Copyright © 2020 Sathish Kumar. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, AVAudioRecorderDelegate {
  
  @IBOutlet weak var startOrStopButton: UIButton!
  var recordingSession: AVAudioSession!
  var audioRecorder: AVAudioRecorder!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    startOrStopButton.isHidden = true
    recordingSession = AVAudioSession.sharedInstance()

    do {
      try recordingSession.setCategory(.playAndRecord, mode: .default, options: [])
      try recordingSession.setActive(true, options: [])
      recordingSession.requestRecordPermission { [unowned self] allowed in
        DispatchQueue.main.async {
          if allowed {
            self.startOrStopButton.isHidden = false
          } else {
            print("Failed to get the permisssion")
          }
        }
      }
    } catch {
      print("Failed to set audio category")
    }
  }
  
  @IBAction func startOrStopButtonClicked(_ sender: UIButton) {
    if audioRecorder == nil {
      startRecording()
    } else {
      finishRecording(true)
    }
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  func startRecording() {
    let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
    let settings = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 12000,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]

    do {
      audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
      audioRecorder.delegate = self
      audioRecorder.record()
    } catch {
      finishRecording(false)
    }

  }

  func finishRecording(_ success: Bool) {
    audioRecorder.stop()
    audioRecorder = nil
    if success {
      startOrStopButton.setTitle("Record", for: .normal)
    } else {
      startOrStopButton.setTitle("Stop Record", for: .normal)
    }
  }


  // MARK: delegate methods

  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if !flag {
      finishRecording(false)
    }
  }

}
