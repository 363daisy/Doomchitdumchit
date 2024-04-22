//
//  DiaryEntryView.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/13/24.
//

import SwiftUI


struct DiaryEntryView: View {

    let buttons = ["기쁨", "행복","설렘", "평온", "우울", "화남", "피곤", "슬픔"]
    @EnvironmentObject var selectedSongData: SelectedSongData
    private var title: String {
        selectedSongData.title
    }
    private var singer: String {
        selectedSongData.singer
    }
    @State public var buttonSelected: String=""
    @Binding var currentDate: Date
    @Binding var firstNaviLinkActive: Bool
    @State private var isDiaryViewActive = false
    @State private var returnNaviLinkActive = false
   
    
    var body: some View {
        NavigationView{
            VStack{
                Text("\(formattedDate()) 에는..")
                    .font(.title).bold()
                    .padding(.bottom,40)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                ZStack{
                    Image("lp")
                        .resizable()
                        .frame(width: 142, height: 142)
                        .padding(.leading, 71)
                        .shadow(radius: 4, y: 4)
                    //                Circle()
                    //                    .frame(width: 50, height: 50)
                    //                    .foregroundColor(.white)
                    //                    .padding(.leading, 71)
                    if let image = selectedSongData.image { // 이미지가 비어있지 않은 경우에만 표시
                        AsyncImage(url: URL(string: image)){ result in
                            result.image?
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            //                            .scaledToFill()
                            
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }.padding(.leading, 71)
                        
                        
                    } else {
                        // 이미지가 없는 경우 또는 비어있는 경우에 대한 처리
                        EmptyView()
                    }
                    Button{
                        
                    }label: {
                        ZStack{
                            
                            Rectangle()
                                .frame(width: 152, height: 152)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            //                                .overlay(
                            //                                    //앨범커버추가
                            //
                            //
                            //                                )
                            //                            if let image = selectedSongData.image {
                            //                                AsyncImage(url: URL(string: image))
                            //                            } else {
                            //                                EmptyView()
                            //                            }
                            
                            if let image = selectedSongData.image { // 이미지가 비어있지 않은 경우에만 표시
                                AsyncImage(url: URL(string: image)){ result in
                                    result.image?
                                        .resizable()
                                        .scaledToFill()
                                }
                                .frame(width: 152, height: 152)
                                
                            } else {
                                // 이미지가 없는 경우 또는 비어있는 경우에 대한 처리
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: 152, height: 152)
                                    .foregroundColor(.blue)
                            }
                            //
                            NavigationLink(destination: MusicSearchView(returnNaviLinkActive:$returnNaviLinkActive),isActive: $returnNaviLinkActive){
                                Image(systemName: "plus")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                            }
                        }
                    }.padding(.trailing, 71)
                }
                
                
                
                Text(title)
                    .font(.title2)
                    .bold()
                Text(singer)
                    .padding(.bottom, 30)
                Text("오늘 하루는 어떠셨나요?")
                    .font(.title3)
                    .bold()
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],spacing: 8) {
                    ForEach(0..<buttons.count){ button in
                        Button(action: {
                            self.buttonSelected = buttons[button]
                        }){
                            Text(self.buttons[button])
                                .padding()
                                .foregroundColor(self.buttonSelected == buttons[button] ? Color.blue : Color.gray)
                                .background(.white)
                                .frame(width: 84, height: 45)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(self.buttonSelected == buttons[button] ? Color.blue : Color.gray, lineWidth: 1)
                                )
                        }
                    }
                }.padding(.bottom,40)
                
                NavigationLink(destination: DiaryWriteView(buttonSelected: $buttonSelected, currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive)){
                    RoundedRectangle(cornerRadius: 30)
                    //버튼 선택시 활성화
                        .foregroundColor(self.buttonSelected != "" ? Color.blue : Color.gray)
                        .frame(width: 240, height: 45)
                        .overlay(
                            Text("일기 쓰러가기")
                                .foregroundColor(.white)
                        )
                }
                NavigationLink(destination: DiaryView(currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive), isActive: $isDiaryViewActive) {
                    EmptyView()
                }
                Button(action: {
                    saveDiaryEntry()
                    isDiaryViewActive = true
                }, label: {
                    Text("오늘은 건너가기").underline()
                        .foregroundColor(.gray)
                        .padding()
                })
                
            }
            .padding(.horizontal)
            .padding(.bottom,30)
        }.navigationBarBackButtonHidden()
    }
    // 선택한 날짜를 원하는 형식으로 표시할 수 있는 헬퍼 메서드
        private func formattedDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.string(from: currentDate)
        }
    // 일기 항목을 저장하는 비동기 함수
        private func saveDiaryEntry() {
            // tasks 배열에 일기 항목을 추가하기 전에 데이터를 준비하고 처리
            let newTask = DiarySection(diaries: [
                Diary(title: "", emotion: buttonSelected, photo: [], tag: "", toggle: true, date: currentDate,Songtitle: title, singer: singer,albumCover: selectedSongData.image ?? "")
            ], date: currentDate)
            
            // 비동기 작업을 수행하고 작업 완료 후 상태를 업데이트
            DispatchQueue.global().async {
                // tasks 배열에 항목 추가
                DiaryData.append(newTask)
                
                // 작업 완료 후 UI 업데이트
                DispatchQueue.main.async {
                    // isDiaryViewActive 상태를 true로 변경하여 NavigationLink 활성화
                    isDiaryViewActive = true
                }
            }
        }
}

#Preview {
    DiaryEntryView(currentDate: .constant(Date()), firstNaviLinkActive: .constant(true))
}
