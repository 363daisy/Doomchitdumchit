import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("이달의 일기")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
            MonthlyRecordView()
                .tabItem {
                    Image(systemName: "record.circle.fill")
                    Text("월간레코드")
                }
//            MyPageView()
//                .tabItem {
//                    Image(systemName: "person")
//                    Text("MY")
//                }
        }
    }
}

#Preview {
    ContentView()
}
