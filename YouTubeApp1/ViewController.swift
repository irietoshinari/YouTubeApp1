//
//  ViewController.swift
//  YouTubeApp1
//
//  Created by USER on 2020/07/26.
//
//
//import UIKit
//
//import Alamofire
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var videoListCollectionView: UICollectionView!
//
//    private let cellId = "cellId"
//    private var videoItems = [Item]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        videoListCollectionView.delegate = self
//        videoListCollectionView.dataSource = self
//
////        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
//
//        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
//
//        fatchYoutubeSerachInfo()
//
//}
//
//private func fatchYoutubeSerachInfo(){
//
//    let urlString = "https://www.googleapis.com/youtube/v3/search?q=lebronjames&key=AIzaSyDmwN3pSyT68bz-NAUbq2yzYfK12ygHuZQ&part=snippet"
//
//    let request = AF.request(urlString)
//
//    request.responseJSON { (response) in
//        do {
//            guard let data = response.data else { return }
//             let decode = JSONDecoder()
//             let video = try decode.decode(Video.self, from: data)
//             self.videoItems = video.items
//
//            self.videoListCollectionView.reloadData()
//
//        } catch{
//            print("変換に失敗しました: ", error)
//        }
//
//       print("response: ", response)
//
//    }
//}
//}
//
//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = self.view.frame.width
//
//        return .init(width: width, height: width)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoListCell
//        return cell
//    }
//
//
//}


import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var videoListCollectionView: UICollectionView!
    
    private let cellId = "cellId"
    private var  videoItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoListCollectionView.delegate = self
        videoListCollectionView.dataSource = self
        
        videoListCollectionView.register(UINib(nibName: "VideoListCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        fetchYoutubeSerachInfo()
        
    }
    
    private func fetchYoutubeSerachInfo(){
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=lebronjames&key=AIzaSyDmwN3pSyT68bz-NAUbq2yzYfK12ygHuZQ&part=snippet"
        
        let request = AF.request(urlString)
        
        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let video = try decode.decode(Video.self, from: data)
               
                self.videoItems = video.items
                
                let id = self.videoItems[0].snippet.channelId
                self.fetchYoutubeChannelInfo(id: id)
                
                
                
            } catch {
                print("変換に失敗しました。: ", error)
            }
        }
    }
    
    private func fetchYoutubeChannelInfo(id: String){
        let urlString = "https://www.googleapis.com/youtube/v3/channels?&key=AIzaSyDmwN3pSyT68bz-NAUbq2yzYfK12ygHuZQ&part=snippet&id=\(id)"
        
        let request = AF.request(urlString)
        
        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let decode = JSONDecoder()
                let channel = try decode.decode(Channel.self, from: data)
                self.videoItems.forEach { (item) in
                    item.channel = channel
                }
//                self.videoItems = video.items
                
                self.videoListCollectionView.reloadData()
                
            } catch {
                print("変換に失敗しました。: ", error)
            }
        }
    }
    

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = videoListCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoListCell
        cell.videoItem = videoItems[indexPath.row]
        return cell
    }

    
}
