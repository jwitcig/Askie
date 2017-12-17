//
//  EmojiCollectionViewCell.swift
//  Askie
//
//  Created by Developer on 6/16/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    override var reuseIdentifier: String? {
        return "EmojiCell"
    }
    
    @IBOutlet weak var emojiLabel: EmojiLabel!
    
    var emojiCode: Int = 0 {
        didSet {
            emojiLabel.emojiCode = emojiCode
        }
    }
    
}
