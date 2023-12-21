//
//  BusReminderApp.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 21/12/2023.
//

import SwiftUI
import GoogleMaps

@main
struct BusReminderApp: App {
    
    init() {
        GMSServices.provideAPIKey("AIzaSyBzXKSCi5fvi6ha15YDS8eyIz0jfMnsGX8")
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
