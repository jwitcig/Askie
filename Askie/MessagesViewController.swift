//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Developer on 6/15/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import UIKit
import Messages
import ReplayKit

class MessagesViewController: MSMessagesAppViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var characterDrawer: UICollectionView!
    
    @IBOutlet weak var drawerView: DrawerView!
    
    @IBOutlet weak var animatorView: UIView!
    
    let emojiRanges = [
        0x1F601...0x1F64F,
        0x2702...0x27B0,
        0x1F680...0x1F6C0,
        0x1F170...0x1F251
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterDrawer.reloadData()
    }
    
    @IBAction func startRecording() {
        let recorder = RPScreenRecorder.shared()
        recorder.isMicrophoneEnabled = true
        
        print("start pressed: \(recorder.isAvailable)")
        
        recorder.startRecording(withMicrophoneEnabled: true) { error in
            
            print("recording starting")
            
            print("starting error: \(error)")
        }
    }
    
    @IBAction func stopRecording() {
        print("stop pressed")
        
        RPScreenRecorder.shared().stopRecording { (previewViewController, error) in
            
            print("recording stopping")
            
            print("stopping error: \(error)")
            
            self.present(previewViewController!, animated: true, completion: nil)
        }
    }
    
    // MARK: - Conversation Handling
    
    /*
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        
        if characterDrawer == nil {
            self.view.addSubview(characterDrawer)
        }
        characterDrawer.reloadData()
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
        
        characterDrawer?.removeFromSuperview()
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.

        if characterDrawer == nil {
            self.view.addSubview(characterDrawer)
        }
        characterDrawer.reloadData()
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
 */
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojiRanges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiRanges[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let emojiRange = emojiRanges[indexPath.section]
        
        let emojiCode = Array(emojiRange)[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCollectionViewCell
        
        cell.emojiCode = emojiCode
        cell.emojiLabel.font = UIFont(name: "Times", size: 100)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("emoji selected")
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell

        let emojiLabel = EmojiLabel(frame: CGRect(x: 30, y: 30, width: 100, height: 100), emojiCode: selectedCell.emojiCode)

        animatorView.addSubview(emojiLabel)
    }
    
    var isDrawerOpen = true
    
    @IBAction func toggleOpen() {
        if isDrawerOpen {
            closeDrawer()
            isDrawerOpen = false
        } else {
            openDrawer()
            isDrawerOpen = true
        }
    }
    
    var drawerSize: CGSize {
        return CGSize(width: self.view.frame.width, height: 240)
    }
    
    func openDrawer() {
        drawerView.frame = CGRect(origin: CGPoint(x: 0, y: self.view.frame.height-drawerSize.height), size: drawerSize)
    }
    
    func closeDrawer() {
        drawerView.frame = CGRect(origin: CGPoint(x: 0, y: self.view.frame.height-40), size: drawerSize)
    }
   
}
