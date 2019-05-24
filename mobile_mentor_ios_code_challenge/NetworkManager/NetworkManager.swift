//
//  NetworkManager.swift
//  mobile_mentor_ios_code_challenge
//
//  Created by eli dangerfield on 5/23/19.
//  Copyright © 2019 Elite Endurance Louisville. All rights reserved.
//

import Foundation

let BASE_URL = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term="
let ALBUM_SONGS_URL = "https://itunes.apple.com/lookup?entity=song&id="

class NetworkManager{
    
    static let instance = NetworkManager()
    
    func getAlbums (searchRequest: String, completion: @escaping ([Album])->()) {
        var albums = [Album]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(BASE_URL)\(searchString)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let albumsResults = json["results"] as? NSArray {
                        for album in albumsResults {
                            if let albumInfo = album as? [String: AnyObject] {
                                guard let artistName = albumInfo["artistName"] as? String else {return}
                                guard let artworkUrl100 = albumInfo["artworkUrl100"] as? String else {return}
                                guard let collectionId = albumInfo["collectionId"] as? Int else {return}
                                guard let collectionName = albumInfo["collectionName"] as? String else {return}
                                guard let country = albumInfo["country"] as? String else {return}
                                guard let primaryGenreName = albumInfo["primaryGenreName"] as? String else {return}
                                guard let releaseDate = albumInfo["releaseDate"] as? String else {return}
                                let releaseDateFormatted = releaseDate.prefix(4)
                                let albumInstance = Album(artistName: artistName, artworkUrl100: artworkUrl100, collectionId: collectionId, collectionName: collectionName, country: country, primaryGenreName: primaryGenreName, releaseDate: String(releaseDateFormatted))
                                albums.append(albumInstance)
                            }
                        }
                        completion(albums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
            }.resume()
    }
    
    
    func getAlbumTracks (collectionId: Int, completion: @escaping ([Song]) -> ()) {
        var songs = [Song]()
        let url = URL(string: "\(ALBUM_SONGS_URL)\(collectionId)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let songResults = json["results"] as? NSArray {
                        for song in songResults {
                            // 0 element is album info
                            if songResults.index(of: song) != 0 {
                                if let songInfo = song as? [String: AnyObject] {
                                    guard let songName = songInfo["trackName"] as? String else {return}
                                    guard let songNumber = songInfo["trackNumber"] as? Int else {return}
                                    let song = Song(songName: songName, songNumber: songNumber)
                                    songs.append(song)
                                }
                            }
                        }
                        completion(songs)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
            }.resume()
    }
}
