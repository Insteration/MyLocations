//
//  Functions.swift
//  MyLocations
//
//  Created by Artem Karmaz on 3/13/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation


// Аннотация @escaping необходима для замыканий, которые не выполняются немедленно. Это так, что Свифт знает, что он должен удерживать это закрытие некоторое время.

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
    return paths[0]
}()

let CoreDataSaveFailedNotification = Notification.Name(rawValue: "CoreDataSaveFailedNotification")

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error :\(error)")
    NotificationCenter.default.post(name: CoreDataSaveFailedNotification, object: nil)
}
