//
//  DairyComponent.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/15/24.
//

import SwiftUI

struct DairyComponent: View{
    let userName: String
    var date: Date
    var songName: String
    var bodyContent: String
    var tags: String
    var cover: String?
    var image: String = "nana"
    
    var body: some View{
        VStack(alignment:.leading){
            HStack{
//                Circle()
//                    .frame(width: 22, height: 22)
                Image(image)
                    .resizable()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 22, height: 22)
                    .scaledToFit()
                Text(userName)
            }
            .padding(.leading, 10)
            .padding(.bottom)
            .offset(y:14)
            HStack{
                VStack{
                    ZStack{
                        Image("lp")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .shadow(radius: 4, y:4)
                        
                        if let cover = cover, !cover.isEmpty {
                                                AsyncImage(url: URL(string: cover)) { result in
                                                    if let image = result.image {
                                                        image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    //                            .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 40, height: 40)
                                    
                                }
                            }

                            } else {
                                // 이미지가 없는 경우 또는 비어있는 경우에 대한 처리
                                    EmptyView()
                            }
                            
                            
                        
                    }
                    Text(songName).padding(.top, 13).font(.subheadline).bold().lineLimit(1)
                        .padding(.bottom,10)
                }.padding(.leading, 10)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                VStack(alignment:.leading){
                    Text(formattedDateKR(date: date))
                        .bold()
                        .padding(.vertical, 5)
                    Text(bodyContent)
                        .lineLimit(3)
                        .frame(height: 55, alignment: .top)
                    
                        Text(tags)
                            .bold()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .padding(.top,5)
                    
                        
                }.font(.subheadline)
                .padding(.leading, 5)
                .padding(.trailing, 10)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
//            .padding(.horizontal)
        
    }
    
    func formattedDateKR(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    DairyComponent(userName: "나나", date: Date(), songName: "라일락-아이유", bodyContent: "오늘은 4월 15일.", tags: "#태그, #택그, #태그", cover: "")
}
