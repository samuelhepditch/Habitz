//
//  InsightView.swift
//  Habitz
//
//  Created by Sam on 2021-03-20.
//

import SwiftUI
import Combine

struct InsightView: View {
    var body: some View {
        ZStack{
            Color(.systemBackground)
            VStack {
                Text("Habit Insights")
            }
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        InsightView()
    }
}
