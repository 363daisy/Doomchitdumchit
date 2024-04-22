//
//  DiaryWriteView.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/13/24.
//

import SwiftUI
import PhotosUI

struct DiaryWriteView: View {
//    @Binding var path: [String]
    @Binding var buttonSelected : String
    @State private var userDiary=""
    @State private var toggle=true
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedPhotosData: [Data] = []
    @State var tag: String = ""
    @State private var isDiaryViewActive = false
    @Binding var currentDate: Date
    @Binding var firstNaviLinkActive: Bool
    @EnvironmentObject var selectedSongData: SelectedSongData
    @StateObject var test = DiaryDataTest()
    private var albumPhoto:String? {
        selectedSongData.image
    }
    
    private var title: String {
        selectedSongData.title
    }
    private var singer: String {
        selectedSongData.singer
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            Group{
                Text("오늘은 ")
                    .font(.title)
                    .bold()
                + Text("\(buttonSelected)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.blue)
                + Text(" 하루네요!")
                    .font(.title)
                    .bold()
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment:.center)
            

            HStack{
                if let image = selectedSongData.image { // 이미지가 비어있지 않은 경우에만 표시
                    AsyncImage(url: URL(string: image)){ result in
                        result.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
//                            .scaledToFill()
                            
                            .frame(width: 55, height: 55)
                            
                    }
                    

                } else {
                    // 이미지가 없는 경우 또는 비어있는 경우에 대한 처리
                        EmptyView()
                }
//                Image("lp")
//                    .resizable()
//                    .frame(width: 55, height: 55)
                VStack(alignment:.leading){
                    Text(title)
                        .font(.title3)
                        .bold()
                    Text(singer)
                }.padding(.leading,14)
                Spacer()
                Image(systemName: "play.fill")
                    .font(.system(size: 22))
            }.padding(.vertical)
            Text("오늘의 하루를 기록해주세요.").bold().font(.title3)
            ZStack{
                TextEditor(text: $userDiary)
                    .cornerRadius(10)
                    .padding()
                    .frame(width: 361, height: 190)
                    .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                if userDiary.isEmpty{
                    Text("내용을 입력해주세요.")
                        .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .padding(.bottom, 120)
                        .padding(.trailing, 180)
                }
                
            }
           ScrollView(.horizontal) {
               HStack{
                   PhotosPicker(selection: $selectedItems,maxSelectionCount: 5, matching: .images) {
                       Image(systemName: "photo")
                           .frame(width: 84, height: 84)
                           .foregroundColor(.gray)
                           .font(.title2)
                           .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                           )
                       
                   }
                   .onChange(of: selectedItems) { newItems in
                       for newItem in newItems {
                           Task {
                               if let data = try? await newItem.loadTransferable(type: Data.self) {
                                   if !selectedPhotosData.contains(data){
                                       selectedPhotosData.append(data)
                                   }
                               }
                           }
                       }
                   }
                   
                   ForEach(selectedPhotosData.indices, id: \.self) { index in
                       let photoData = selectedPhotosData[index]
                       if let image = UIImage(data: photoData) {
                           ZStack{
                               Image(uiImage: image)
                                   .resizable()
                                   .frame(width: 84, height: 84)
                                   .cornerRadius(10.0)
                                   .padding(.vertical, 8)
                               Image(systemName: "x.square")
                                   .font(.system(size: 22))
                                   .padding(.leading, 50)
                                   .padding(.bottom, 50)
                                   .foregroundColor(.white)
                                   .onTapGesture {
                                       selectedPhotosData.remove(at: index)
                                   }
                           }
                       }
                   }
               }
           }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            HStack{
                Text("태그")
                TextField("#태그를 입력하세요.", text: $tag)
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }.padding(.bottom)
            Toggle(isOn: $toggle, label: {
                Text("공개")
            }).padding(.bottom,16)
                .onTapGesture {
                    toggle = !toggle
                    
                }
            NavigationLink(destination: DiaryView(currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive), isActive: $isDiaryViewActive) {
                        EmptyView()
                    }
            Button(action: {
                saveDiaryEntry()
                isDiaryViewActive = true
            }, label: {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.blue)
                    .frame(width: 240, height: 45)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(
                        Text("저장")
                            .foregroundColor(.white)
                    )
            })
        }.padding()
            .onAppear {
                if let task = DiaryData.first(where: { task in
                    return isSameDay(date1: task.date, date2: currentDate)
                }) {
                    task.diaries.forEach { task in
                        // 찾은 일기 항목의 정보를 사용하여 뷰의 상태 초기화
                        userDiary = task.title
                        selectedPhotosData = task.photo
                        toggle = task.toggle
                        buttonSelected = task.emotion
                        tag = task.tag
                    }
                }
            }
        
    }
    // 일기 항목을 저장하는 비동기 함수
        private func saveDiaryEntry() {
            // tasks 배열에 일기 항목을 추가하기 전에 데이터를 준비하고 처리
            let newTask = DiarySection(diaries: [
                Diary(title: userDiary, emotion: buttonSelected, photo: selectedPhotosData, tag: tag, toggle: toggle, date: currentDate, Songtitle: title, singer: singer, albumCover: albumPhoto ?? "title")
            ], date: currentDate)
            
            // 비동기 작업을 수행하고 작업 완료 후 상태를 업데이트
            DispatchQueue.global().async {
                // tasks 배열에 항목 추가
                    
                   
                if let diarySectionIndex = DiaryData.firstIndex(where: { diarySection in
                    return isSameDay(date1: diarySection.date, date2: currentDate)
                }) {
                        var diarySection = DiaryData[diarySectionIndex]
                            
                            // diarySection의 diaries 배열에 접근하여 각 Diary 객체를 수정
                            for diaryIndex in 0..<diarySection.diaries.count {
                                var diary = diarySection.diaries[diaryIndex]
                                
                                // Diary 객체의 속성을 수정
                                diary.title = userDiary
                                diary.photo = selectedPhotosData
                                diary.toggle = toggle
                                diary.emotion = buttonSelected
                                diary.tag = tag
                                diary.Songtitle = title
                                diary.singer = singer
                                diary.albumCover = albumPhoto ?? ""
                                
                                // 수정된 Diary 객체를 다시 diaries 배열에 할당
                                diarySection.diaries[diaryIndex] = diary
                            }
                            
                            // 수정된 diarySection을 다시 DiaryData 배열에 할당
                            DiaryData[diarySectionIndex] = diarySection
                }else{
                    DiaryData.append(newTask)
                }
                // 작업 완료 후 UI 업데이트
                DispatchQueue.main.async {
                    // isDiaryViewActive 상태를 true로 변경하여 NavigationLink 활성화
                    isDiaryViewActive = true
                }
            }
        }
    func isSameDay(date1: Date, date2: Date) -> Bool {
        
        return Calendar.current.isDate(date1, inSameDayAs: date2)
        
    }
    func findTask(){
        
    }
}

//#Preview {
//    DiaryWriteView(buttonSelected: Binding.constant("기쁨"))
//}
struct DiaryWriteView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryWriteView(buttonSelected: .constant("기쁨"), currentDate: .constant(Date()),firstNaviLinkActive: .constant(true))
    }
}
