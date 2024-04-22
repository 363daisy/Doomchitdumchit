//
//  CalendarView.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/14/24.
//

import SwiftUI

struct CalendarView: View {
    @State var currentDate: Date = Date()
    @State private var navPath: [String] = []
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // Custom Date Picker
                    CustomDatePicker(currentDate: $currentDate)
                }
                .padding(.vertical)
            }
        }.navigationBarHidden(true)
    }
}

#Preview {
    CalendarView()
}

