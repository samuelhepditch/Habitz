//
//  InsightView.swift
//  Habitz
//
//  Created by Sam on 2021-03-20.
//

import SwiftUI
import Combine

struct InsightView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(
        entity: Insights.entity(),
        sortDescriptors: []
    ) var insights: FetchedResults<Insights>
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Form {
                Section {
                    Text("Habit Insights")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
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
