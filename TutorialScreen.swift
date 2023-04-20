//
//  TutorialScreen.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/19.
//

import SwiftUI

struct TutorialScreen: View {
    @State private var showText = true
    var body: some View {
        VStack{
            Spacer()
            HStack{
                if showText {
                    Text("Sense it.")
                        .font(.largeTitle)
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showText = false
                    }
                }
            }
            Spacer()
            Spacer()
        }
    }
}
