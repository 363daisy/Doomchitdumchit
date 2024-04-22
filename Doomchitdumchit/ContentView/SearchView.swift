//
//  SearchView.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/13/24.
//

import SwiftUI

struct SearchView: View {
    let array = [
            "나나", "안나", "해나", "조이", "온브", "쿠미",
            "에이스", "테오", "데이지", "니니", "레모니", "나기",
            "윈터", "키니", "마스", "원", "하래", "젠", "제라스", "레디", "피카"
        ]
        
        @State private var searchText = ""
    @State private var isListVisible = false
    @State private var dairyDatw = DiaryData
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        isListVisible = true // 검색창 터치 시 리스트 보이기
                                        }
                ZStack{
                    ScrollView{
                        VStack{
                            //for
//                            ForEach(dairyDatw) { data in
//                                                    
//                                ForEach(data.diaries) { diary in
//                                    DairyComponent(
//                                        userName: array[1],
//                                        date: diary.date,
//                                        songName: diary.Songtitle,
//                                        bodyContent: diary.title,
//                                        tags: diary.tag,
//                                        image: "anna2"
//                                    )
//                                }
//                            }
                            DairyComponent(
                                userName: array[0],
                                date: getSampleDate(offset: -2),
                                songName: "Intro : Beggin’ you (Intro : Beggin’ you)",
                                bodyContent: "오늘은 마치 동화 속 주인공이 된 것 같은 하루였어요. 아침에 일어나니 창밖을 보니 하늘은 맑고 새들의 지저귀는 소리가 들려왔어요. 아침 식사 후엔 마치 요술 봉으로 일상을 바꾸어 놓은 것 같아요. 나무들이 마법처럼 아름답게 보이고, 길을 걷는 사람들마저 웃는 얼굴로 가득 차 있었어요.",
                                tags: "#원어스, #동화같은하루, #즐거움",
                                image: "nana"
                            )
                            DairyComponent(
                                userName: array[1],
                                date: getSampleDate(offset: -3),
                                songName: "귀를 기울이면",
                                bodyContent: "오늘은 마치 어릴 적으로 돌아간 것 같은 하루였어요. 아침에 일어나니 마치 어릴 적 방황하던 숲 속을 걷는 듯한 기분이었어요. 새벽의 신선한 공기와 함께 한 시간은 마치 모험을 떠난 것처럼 신나고 흥미진진했어요. 오랜만에 좋아했던 동화책을 읽으며 하루를 보내고, 잔잔한 노래 소리에 귀를 기울이며 마치 시간을 멈춘 듯한 행복한 시간을 보냈어요.",
                                tags: "#가을아침, #숲속, #귀를기울이면",
                                image: "anna2"
                            )
                            DairyComponent(
                                userName: array[2],
                                date: getSampleDate(offset: -4),
                                songName: "숲의 아이",
                                bodyContent: " 아침에 일어나자마자 주위에는 음악처럼 맑고 상쾌한 공기가 넘쳐났어요. 각각의 일들이 마치 조화롭게 연주되는 음악곡처럼 느껴졌어요. 길을 걷는 발소리, 바람에 스치는 나뭇잎 소리마저도 하나의 멜로디로 들려왔어요. 하루 종일 음악에 취해 즐거움을 느낀 시간이었",
                                tags: "#미세먼지제로, #음악회, #asmr",
                                image: "sun"
                            )
                            DairyComponent(
                                userName: array[3],
                                date: getSampleDate(offset: -5),
                                songName: "다시 여기 바닷가",
                                bodyContent: "모래사장을 걷는 듯한 발걸음은 자유롭고 경건한 기분을 주었어요. 저녁에는 친구들과 함께 바닷가에서 놀며 즐거운 시간을 보내고, 별빛 아래서 맥주 한 잔 마시며 마무리했어요. 정말 행복한 하루였습니다.",
                                tags: "#바닷가, #모래사장",
                                image: "joy"
                            )
                            DairyComponent(
                                userName: array[4],
                                date: getSampleDate(offset: -6),
                                songName: "How You Like That",
                                bodyContent: "오늘은 마치 예술가의 눈을 빌린 듯한 하루였어요. 아침에 일어나 창 밖을 내다보니 빛과 그림자가 만드는 아름다운 조화가 눈에 들어왔어요. 일상의 사소한 순간들이 마치 캔버스 위에 그려지는 듯 풍부하고 다채로웠어요. 눈에 띄는 모든 것들이 예술 작품처럼 보였고",
                                tags: "#예술가의눈, #작품, #빛",
                                image: "on"
                            )
                            ForEach(dairyDatw) { data in
                                                    
                                ForEach(data.diaries) { diary in
                                    DairyComponent(
                                        userName: "나나",
                                        date: diary.date,
                                        songName: diary.Songtitle,
                                        bodyContent: diary.title,
                                        tags: diary.tag,
                                        cover: diary.albumCover,
                                        image: "nana"
                                        
                                    )
                                }
                            }
                            
                        }
                    }.padding()
                    if isListVisible { // 리스트 가시성에 따라 보이기
                        List {
                            ForEach(array.filter { $0.hasPrefix(searchText) || searchText.isEmpty }, id: \.self) { text in
                                Text(text)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .onTapGesture {
                            hideKeyboard() // 리스트 터치 시 키보드 숨기기
                        }
                    }
                    
                } 
            }
            .navigationBarTitle("검색")
            
            
//            .navigationBarItems(trailing:
//                                    HStack{
//                Button(action: {
//                }) {
//                    HStack {
//                        Text("유저이름")
//                            .foregroundColor(.black)
//                        Image(systemName: "folder.fill")
//                    }
//                }
//            }
//            )
        }.onAppear{
            self.dairyDatw = DiaryData
        }
//
    }
}



struct SearchBar: View {
    
    @Binding var text: String
 
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
 
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    SearchView()
}


