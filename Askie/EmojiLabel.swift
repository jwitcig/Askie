//
//  EmojiLabel.swift
//  Askie
//
//  Created by Developer on 6/16/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import UIKit

class EmojiLabel: UILabel, UIGestureRecognizerDelegate {

    var emojiCode: Int = 0 {
        didSet {
            self.text = String(UnicodeScalar(emojiCode))
        }
    }
    
    convenience init(emojiCode: Int) {
        self.init(frame: CGRect.zero, emojiCode: emojiCode)
    }
    
    init(frame: CGRect, emojiCode: Int) {
        self.emojiCode = emojiCode
        
        super.init(frame: frame)
        
        self.font = UIFont(name: "Times", size: 100)
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(EmojiLabel.panGestureOccurred(recognizer:)))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
        
        let scaleGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(EmojiLabel.zoomGestureOccurred(recognizer:)))
        scaleGestureRecognizer.delegate = self
        self.addGestureRecognizer(scaleGestureRecognizer)
        
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(EmojiLabel.rotateGestureOccurred(recognizer:)))
        rotateGestureRecognizer.delegate = self
        self.addGestureRecognizer(rotateGestureRecognizer)

        pushValues()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func pushValues() {
        let code = emojiCode
        self.emojiCode = code
    }
    
    func panGestureOccurred(recognizer: UIPanGestureRecognizer) {
        self.transform = self.transform.translateBy(x: recognizer.translation(in: self).x, y: recognizer.translation(in: self).y)
        recognizer.setTranslation(CGPoint.zero, in: self)
    }
    
    func zoomGestureOccurred(recognizer: UIPinchGestureRecognizer) {
        self.transform = self.transform.scaleBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }
    
    func rotateGestureOccurred(recognizer: UIRotationGestureRecognizer) {
        self.transform = self.transform.rotate(recognizer.rotation)
        recognizer.rotation = 0
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        touches.forEach { touch in
//            let localLocation = touch.location(in: self)
//            
//            guard let location = self.superview?.convert(localLocation, from: self) else {
//                return
//            }
//            
//            let adjustedOrigin = CGPoint(x: location.x - self.frame.width/2, y: location.y - self.frame.height/2)
//            
//            self.frame = CGRect(origin: adjustedOrigin, size: self.frame.size)
//        }
//    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
