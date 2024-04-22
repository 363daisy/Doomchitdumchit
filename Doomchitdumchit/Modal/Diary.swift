//
//  Task.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/15/24.
//
import Foundation
import SwiftUI

struct Diary: Identifiable {
    var id = UUID().uuidString
    var title: String
    var emotion: String
    var photo: [Data]
    var tag: String
    var toggle: Bool
    var date: Date
    var Songtitle: String
    var singer: String
    var albumCover: String
    var color: Color{
        switch emotion {
                case "기쁨":
                    return .color1
                case "행복":
                    return .color2
                case "설렘":
                    return .color3
                case "평온":
                    return .color4
                case "우울":
                    return .color5
                case "화남":
                    return .color6
                case "피곤":
                    return .color7
                default:
                    return .color8  // 다른 감정에 대한 색상을 지정하려면 여기에 추가
                }
    }
}


struct DiarySection: Identifiable {
    var id = UUID().uuidString
    var diaries: [Diary]
    var date: Date

    
}


func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

class DiaryDataTest: ObservableObject {
    @Published var DiaryData: [DiarySection] = [
//        DiarySection(diaries: [
//            Diary(title: "dks", emotion: "행복",photo: [], tag: "#행복", toggle: true, date: getSampleDate(offset: -8), Songtitle: "",singer: "", albumCover: ""),
//        ], date:   getSampleDate(offset: -8)),
//        DiarySection(diaries: [
//            Diary(title: "dksfddf", emotion: "행복",photo: [], tag: "#행복", toggle: true, date: getSampleDate(offset: 2), Songtitle: "",singer: "", albumCover: ""),
//        ], date:   getSampleDate(offset: 2)),
//        DiarySection(diaries: [
//            Diary(title: "dks", emotion: "행복",photo: [], tag: "#행복", toggle: true, date: getSampleDate(offset: 10), Songtitle: "",singer: "", albumCover: ""),
//        ], date:   getSampleDate(offset: 10)),
//        DiarySection(diaries: [
//            Diary(title: "dks", emotion: "행복",photo: [], tag: "#행복", toggle: true, date: getSampleDate(offset: 22), Songtitle: "",singer: "", albumCover: ""),
//        ], date:   getSampleDate(offset: 22)),

    ]
}


var DiaryData: [DiarySection] = [
//    DiarySection(diaries: [
//        Diary(title: "오늘은 새로운 책을 읽는 즐거운 시간을 보냈습니다. 책의 제목은 바다를 보다라는 소설이었는데, 그 안에는 매력적인 등장인물과 아름다운 풍경들이 펼쳐져 있었습니다. 책을 읽으며 마치 그 세계에 빠져들었던 것 같아 행복했습니다. 이 책을 통해 새로운 지식과 감정을 경험할 수 있어 기분이 상쾌했습니다.", emotion: "행복",photo: [], tag: "#책, #바다를보다, #행복", toggle: true, date: getSampleDate(offset: -8),Songtitle: "빙고", singer: "거북이", albumCover: ""),
//    ], date:   getSampleDate(offset: -8)),
//    DiarySection(diaries: [
//        Diary(title: "오늘은 가족과 함께 보내는 시간을 가졌습니다. 모두 함께 저녁 식사를 하면서 이야기를 나누고 웃음을 나누었습니다. 가족들과 함께 있는 순간은 항상 특별하고 소중하게 느껴집니다. 이런 소중한 시간을 자주 가질 수 있어서 참으로 행복합니다.", emotion: "즐거움",photo: [], tag: "#즐거움, #소중한시간, #가족", toggle: true, date: getSampleDate(offset: 2),Songtitle: "Rollin", singer: "브레이브걸스", albumCover: ""),
//    ], date:   getSampleDate(offset: 2)),
//    DiarySection(diaries: [
//        Diary(title: "오늘은 뮤지엄을 방문하여 작품들을 감상했습니다. 예술은 마음을 감동시키고 새로운 시각을 선사해 줍니다. 다양한 작품을 관람하면서 창의성과 감성을 자극받았습니다. 또한, 현대 미술의 다양성을 느낄 수 있어서 유익한 시간이었습니다.", emotion: "행복",photo: [], tag: "#뮤지엄, #작품, #자극", toggle: true, date: getSampleDate(offset: 10),Songtitle: "닐리리맘보", singer: "블락비", albumCover: ""),
//    ], date:   getSampleDate(offset: -5)),
//    DiarySection(diaries: [
//        Diary(title: "오늘은 날씨가 좋아서 산책을 다녀왔습니다. 공원을 걸으면서 신선한 공기를 마시고 햇볕 아래서 산책하는 것은 마음을 편안하게 해줍니다. 주변의 푸릇한 풍경을 감상하며 마음의 여유를 채웠습니다. 산책은 마음과 몸에 모두 좋은 휴식이었습니다.", emotion: "평온",photo: [], tag: "#산책, #풍경, #여유", toggle: true, date: getSampleDate(offset: 22),Songtitle: "가을아침", singer: "아이유", albumCover: ""),
//    ], date:   getSampleDate(offset: 12)),

]
