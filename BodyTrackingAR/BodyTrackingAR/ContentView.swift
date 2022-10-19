//
//  ContentView.swift
//  BodyTrackingAR
//
//  Created by Andrew Ushakov on 7/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
