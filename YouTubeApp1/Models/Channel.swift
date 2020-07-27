//
//  Channel.swift
//  YouTubeApp1
//
//  Created by USER on 2020/07/28.
//

import Foundation

class Channel: Decodable {
    
    let items: [ChannelItem]
    
}

class ChannelItem: Decodable {
    
    let snippet: ChannelSnippet
    
}

class ChannelSnippet: Decodable {
    let thumbnails: Thumbnails
}
