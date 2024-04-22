//
//  SelectedSongData.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/17/24.
//

import Foundation

struct SongInfo{
//    let image: String
    let title: String?
    let singer: String?
}

class SelectedSongData: ObservableObject {
    @Published var title: String
    @Published var singer: String
    @Published var image: String?
//    @Published var img: ArtworkImage?
    
    init(title: String, singer: String, image: String) {
        self.title = title
        self.singer = singer
        self.image = image
    }
}
