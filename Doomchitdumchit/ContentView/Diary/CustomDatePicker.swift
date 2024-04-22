//
//  CustomDatePicker.swift
//  CustomDatePickerDemo
//
//  Created by Thongchai Subsaidee on 29/9/21.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @State var firstNaviLinkActive = false
    @Binding var currentDate: Date
    @State var  currentMonth: Int = 0
//    @State var color: Color = .blue

//    @Binding var path: [String]
    
    var body: some View {
        VStack(spacing: 35) {
            
            // Days
            let days = ["일", "월", "화", "수", "목", "금", "토"]
                        
            HStack(spacing: 20) {
                
                HStack( spacing: 10) {
                    Text("\(extraDate())")
                        .font(.title.bold())
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2 )
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }

                
            }
            .padding(.horizontal)
            
            // Day View...
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                        Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            //Date
            // Lazy Grid..
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                  CardView(value: value)
                        .background(
//                            Capsule()
                            Circle()
                                .frame(width: 48, height: 48)
                                .foregroundColor(.blue)
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                .padding(.bottom,37)
                            
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 10) {
                if let diarySection = DiaryData.first(where: { diarySection in
                    return isSameDay(date1: diarySection.date, date2: currentDate)
                }) {
//                    Text("안나의 일기장")
//                        .font(.title2.bold())
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical , 10)
                    ForEach(diarySection.diaries) { diary in
                        
                        // For custom timing
                        VStack(alignment: .leading, spacing: 10) {
//                            Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                            
//                            Text(task.title)
//                                .font(.title2.bold())
                            NavigationLink(destination: DiaryView(currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive) ){
                                DairyComponent(userName: "나나", date: currentDate, songName: diary.Songtitle, bodyContent: diary.title, tags: diary.tag, cover: diary.albumCover)
                            }.foregroundColor(.black)
                        }.offset(y:-25)
                    }
                }
                else {
                    //오늘의 일기쓰기버튼
                    buttonView(currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive)
                }
            }
//            .padding()

            
        }.padding(.horizontal)
        .onChange(of: currentMonth) { newValue in
            // update month
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        
        VStack {
            
            if value.day != -1 {
                
                if let diarySection = DiaryData.first(where: { diarySection in
                    return isSameDay(date1: diarySection.date, date2: value.date)
                }) {
                    VStack{
                        Text("\(value.day)")
                            .font(.title3.bold())
                            .foregroundColor(isSameDay(date1: diarySection.date, date2: currentDate) ? .yellow : .blue)
                            .frame(maxWidth: .infinity)
                        
//                        Spacer()
                        ForEach(diarySection.diaries) { diary in
                            Group{
                                if isSameDay(date1: diarySection.date, date2: currentDate) {
                                    
                                                // 일정이 있는 경우 앨범 이미지 Circle 표시
                                        AsyncImage(url: URL(string: diary.albumCover)) { result in
                                                    if let image = result.image {
                                                VStack {
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .clipShape(Circle())
                                                        .frame(width: 46, height: 46)
                                                        .opacity(0.5)
                                                        .padding(.bottom, 1)
                                                    
                                                    ZStack{
                                                        RoundedRectangle(cornerRadius: 9)
                                                            .frame(width: 48, height: 20)
                                                            .foregroundColor(diary.color)
                                                        Text(diary.emotion).font(.caption).foregroundColor(.black)
                                                            
                                                    }
                                                }
                                            }
                                        }
                                }else{
                                    if !diary.albumCover.isEmpty {
                                                // 일정이 있는 경우 앨범 이미지 Circle 표시
                                        AsyncImage(url: URL(string: diary.albumCover)) { result in
                                                    if let image = result.image {
                                                VStack {
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .clipShape(Circle())
                                                        .frame(width: 46, height: 46)
//                                                        .opacity(0.8)
                                                        .padding(.bottom, 1)
                                                    
                                                    ZStack{
                                                        RoundedRectangle(cornerRadius: 9)
                                                            .frame(width: 48, height: 18)
                                                            .foregroundColor(diary.color)
                                                        Text(diary.emotion).font(.caption).foregroundColor(.black)
                                                            
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    }else{
                                        Image("lp")
                                            .resizable()
                                            .frame(width: 48, height: 48)
//                                            .opacity(0.8)
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 9)
                                                .frame(width: 48, height: 18)
                                                .foregroundColor(diary.color)
                                            Text(diary.emotion).font(.caption).foregroundColor(.black)
                                                
                                        }
                                    }
                                }
//                                Circle()
//                                    .fill(isSameDay(date1: diarySection.date, date2: currentDate) ? .white : .purple)
//                                    .frame(width: 46, height: 46)
//                                    .opacity(0.5)
                                
                            }.offset(y:-48)
                            
                        }
                        
                    }

                }else {
                    //오늘 날짜색
                    Text("\(value.day)")
                        .font(.title3)
                        .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .black)
                        .frame(maxWidth: .infinity)

                    Spacer()
                }

                
            }
        }
        .padding(.vertical, 0)
        .frame(height: 60, alignment: .top)
            
    }
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        
        return Calendar.current.isDate(date1, inSameDayAs: date2)
        
    }
    
    
    // Extraing year and month for display
    func extraDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        
        let dateString = formatter.string(from: currentDate)
        return dateString
    }

    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting Current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        // Getting Current month date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let dateValue =  DateValue(day: day, date: date)
            return dateValue
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // geting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)
        
        
        // getting date...
        return range!.compactMap{ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 , to: startDate)!
        }
        
    }
    
    
}
struct buttonView: View {
    @Binding var currentDate: Date
//    @Binding var path: [String]
    @Binding var firstNaviLinkActive: Bool
    var body: some View {
        VStack{
            NavigationLink(destination: DiaryEntryView( currentDate: $currentDate, firstNaviLinkActive: $firstNaviLinkActive), isActive: $firstNaviLinkActive){
                RoundedRectangle(cornerRadius: 30)
                //버튼 선택시 활성화
                    .foregroundColor(.blue)
                    .frame(width: 240, height: 45)
                    .overlay(
                        Text("오늘의 일기쓰기")
                            .foregroundColor(.white)
                    )
            }
        }
    }
}
 
