//
//  MonthRecord.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/18/24.
//

import SwiftUI

struct MonthRecord: View {
    var title:String = "노래제목"
    var singer:String = "가수"
    var date: Date = Date()
    var cover: String?
    var body: some View {
        HStack{
            ZStack{
                
                if let cover = cover, !cover.isEmpty {
                                        AsyncImage(url: URL(string: cover)) { result in
                                            if let image = result.image {
                                                image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            //                            .scaledToFill()
                                .frame(width: 55, height: 55)
                                .padding(.trailing,10)
                            
                        }
                    }

                    } else {
                        // 이미지가 없는 경우 또는 비어있는 경우에 대한 처리
//                            EmptyView()
                        Image("lp")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        //                            .scaledToFill()
                            .frame(width: 55, height: 55)
                            .padding(.trailing,10)
                    }
            }
            VStack(alignment: .leading){
                Text(title)
                    .bold()
                Text(singer)
            }
            Spacer()
            Text(formattedDate())
        }
    }
    // 선택한 날짜를 원하는 형식으로 표시할 수 있는 헬퍼 메서드
    private func formattedDate() -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "MM.dd.EEE"
           return formatter.string(from: date)
       }
}

#Preview {
    MonthRecord()
}
