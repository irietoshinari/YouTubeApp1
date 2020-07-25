//
//  VideoListCell.swift
//  YouTubeApp1
//
//  Created by USER on 2020/07/26.
//

import UIKit

class VideoListCell: UICollectionViewCell {
    
    @IBOutlet weak var channelImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        channelImageView.layer.cornerRadius = 40 / 2
    }
    
}

