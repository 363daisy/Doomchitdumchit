//
//  DiaryView.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/13/24.
//

import SwiftUI

struct DiaryView: View {
//    @Binding var path: [String]
    @Environment(\.dismiss) private var dismiss
    @Binding var currentDate: Date
    @Binding var firstNaviLinkActive: Bool
    var body: some View {
        ScrollView(.vertical){
            VStack{
//                Button(action: {
//                               firstNaviLinkActive = false
//                           }, label: {
//                               Text("Main으로 돌아가기")
//                                   .foregroundColor(Color.white)
//                                   .frame(width: 100, height: 60, alignment: .center)
//                                   .background(RoundedRectangle(cornerRadius: 10)
//                                       .fill(Color.purple))
//                           })
                if let index = DiaryData.firstIndex(where: { diarySection in
                    return isSameDay(date1: diarySection.date, date2: currentDate)
                }) {
                    ForEach(DiaryData[index].diaries) { diary in
//                        Button{
////                            path.removeAll()
//                            DiaryData.remove(at:index)
//                            firstNaviLinkActive = false
//                            print($firstNaviLinkActive)
//                            dismiss()
//                            
//                        }label: {
//                            Image(systemName: "trash.fill")
//                                .padding(.leading,5)
//                                .foregroundColor(.black)
//                        }
                        ZStack{
                            Group{
                                Image("lp")
                                    .resizable()
                                    .frame(width: 370, height: 370)
                                if !diary.albumCover.isEmpty {
                                    AsyncImage(url: URL(string: diary.albumCover)) { result in
                                        if let image = result.image {
                                            result.image?
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                            //                            .scaledToFill()
                                                .clipShape(Circle())
                                                .frame(width: 240, height: 240)
                                                .overlay(
                                                    Button{
                                                        print("click")
                                                    }label: {
                                                        Image(systemName: "play.fill")
                                                            .font(.system(size: 70))
                                                            .foregroundColor(.white)
                                                            .padding(.leading, 20)
                                                    }
                                                )
                                            
                                        }
                                    }

                                    } else {
                                        // 이미지가 없는 경우 또는 비어있는 경우에 대한 처리
                                            EmptyView()
                                    }
                                            
                            }.offset(x:-140)
                                
                            HStack{
                                
                                Spacer()
                                VStack(alignment:.trailing){
                                    
                                    Text("")
                                        .navigationBarItems(leading:
                                            Button{
                                                firstNaviLinkActive = false
                                            dismiss()
                                            }label: {
                                                Image(systemName: "house.fill")
                                                    .foregroundColor(.black)
                                            }
                                        )
                                    .navigationBarItems(trailing:
                                            HStack(){
                                        NavigationLink(destination: DiaryWriteView(buttonSelected:Binding.constant("기쁨"),currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive)){
                                                                                    Image(systemName: "square.and.pencil")
                                                                                        .padding(.trailing,5)
                                                                                        .foregroundColor(.black)
                                                                                }
                                                //쓰레기통
                                        Button{
                //                            path.removeAll()
                                            DiaryData.remove(at:index)
                                            firstNaviLinkActive = false
                                            print($firstNaviLinkActive)
                                            dismiss()
                                            
                                        }label: {
                                            Image(systemName: "trash.fill")
                                                .padding(.leading,5)
                                                .foregroundColor(.black)
                                        }
                                            }
                                    )
                                    
                                    Spacer()
                                    VStack(alignment:.leading){
                                        Text(diary.singer).font(.title3)
                                        Text(diary.Songtitle).font(.largeTitle)
                                            .bold()
                                    }.frame(width: 148)
                                        .padding(.leading, 10)
                                    Spacer()
                                    VStack(alignment:.trailing){
                                        HStack{
                                            Image("nana")
                                                .resizable()
                                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                                .frame(width: 22, height: 22)
                                                .scaledToFit()
                                            Text("나나")
                                        }
                                        Text(diary.tag)
                                            .bold()
                                            .foregroundColor(.blue)
                                    }
                                }
                            }.frame(height: 380)
                                .padding(.trailing, 0)
                                .padding()
                            
                        }
                        VStack{
                            Text("\(formattedDate())")
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .bold()
                                .padding(.vertical, 10)
                            Text(diary.title).padding(.bottom,30)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            ScrollView(.horizontal){
                                HStack{
//                                    ForEach(0..<task.photo){_ in
//                                        Image("lp").resizable()
//                                            .frame(width: 83, height: 83)
//                                    }
                                    ForEach(diary.photo, id: \.self) { imageData in
                                        if let uiImage = UIImage(data: imageData) {
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .frame(width: 83, height: 83)
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .padding(.horizontal, 4)
                                        }
                                    }
                                }
                            }
                        }.padding()
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
    func isSameDay(date1: Date, date2: Date) -> Bool {
        
        return Calendar.current.isDate(date1, inSameDayAs: date2)
        
    }
    // 선택한 날짜를 원하는 형식으로 표시할 수 있는 헬퍼 메서드
        private func formattedDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            return formatter.string(from: currentDate)
        }
}

#Preview {
    DiaryView(currentDate: .constant(Date()), firstNaviLinkActive: .constant(true))
}
