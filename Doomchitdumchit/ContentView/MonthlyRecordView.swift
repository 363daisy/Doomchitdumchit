//
//  MonthlyRecordView.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/13/24.
//

import SwiftUI

struct MonthlyRecordView: View {
    @State private var dairyDate = DiaryData
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                //            Text("음악창고").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                HStack{
                    Text("2024.04").font(.title3)
                    Spacer()
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }.font(.title3)
                ScrollView{
                    ForEach(dairyDate) { data in
                                            
                        ForEach(data.diaries) { diary in
                            MonthRecord(title: diary.Songtitle, singer: diary.singer, date: diary.date, cover:diary.albumCover)
                                .padding(.vertical,10)
                        }
                    }
                }
            }
            .navigationTitle("음악창고")
            .padding()
        }
        .onAppear{
            self.dairyDate = DiaryData
        }
       
    }
//    func fetchData(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            dairyDate = DairyData
//        }
//    }
}

//struct RecordView: View {
//    var body: some View {
//        HStack{
//            Image("lp").resizable()
//                .frame(width: 55, height: 55)
//            VStack(alignment:.leading){
//                Text("노래제목").bold()
//                Text("가수")
//            }
//            Spacer()
//            Text("04.01.MON")
//        }.padding(.vertical)
//    }
//}

#Preview {
    MonthlyRecordView()
}
