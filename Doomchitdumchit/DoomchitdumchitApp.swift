//
//  DoomchitdumchitApp.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/12/24.
//

import SwiftUI

@main
struct DoomchitdumchitApp: App {
    var selectedSongData = SelectedSongData(title: "", singer: "", image: "")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(selectedSongData)
        }
    }
}
