//
//  ImageManager.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/17/24.
//

import Foundation
import MusicKit

class ImageManager {
    static func fetchArtworkURL(artwork: Artwork?) -> String? {
//        guard let artwork = artwork else {
//            print("Artwork 정보가 없습니다.")
//            return nil
//        }
//        
        let width = 700
        let height = 700
        
        return artwork?.url(width: width, height: height)?.absoluteString
    }
}
