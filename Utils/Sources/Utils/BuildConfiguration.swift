//
//  BuildConfiguration.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

public enum BuildConfiguration {

    public static var isDebug: Bool {
        #if DEBUG
        true
        #else
        false
        #endif
    }

    public static var isRelease: Bool {
        !isDebug
    }
}
