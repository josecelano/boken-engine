//
//  SceneManager.swift
//  Boken Engine
//
//  Created by Yeray on 22/10/2020.
//  Copyright © 2020 Hyve. All rights reserved.
//

import GameplayKit

public class SceneManager {

    var currentScene: Int!
    var rootView: UIView!
    var appDescription: AppDescription!
    var audioManager = AudioManager()
    var sceneFactory: SceneFactory!

    public init() throws {
        do {
            let storyParser = StoryParser()
            appDescription = try storyParser.decodeJSON()!
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }

    public init(storyContents: String) throws {
        do {
            let storyParser = StoryParser()
            appDescription = try storyParser.decodeJSON(contents: storyContents)!
        } catch {
            throw error
        }
    }

    public func setRootView(_ rootView: UIView) {
        self.rootView = rootView
        sceneFactory = SceneFactory(rootView: self.rootView, sceneManager: self)
    }

    public func setCurrentScene(_ newSceneNumber: Int) {
        currentScene = newSceneNumber
    }

    public func setCurrentScene(_ newSceneId: String) {
        currentScene = appDescription.scenes.firstIndex(where: { $0.sceneId == newSceneId })!
    }

    public func getCurrentScene() -> Int {
        return currentScene
    }

    func startBackgroundMusic(testMode: Bool = false) throws {
        if let backgroundMusicAssetName = appDescription.backgroundMusic {
            do {
                _ = try audioManager.playBackgroundMusic(resourceName: backgroundMusicAssetName)
            } catch {
                throw error
            }
        }
    }

    public func loadTitleScene() throws {
        setCurrentScene(0)
        do {
            try loadCurrentScene()
            try startBackgroundMusic()
        } catch {
            throw error
        }
    }

    func getSceneCount() -> Int {
        return appDescription.scenes.count
    }

    func getSceneDescription(sceneIndex: Int) -> SceneDescription {
        return appDescription.scenes[sceneIndex]
    }

    public func isFirstScene(sceneNumber: Int) -> Bool {
        return sceneNumber == 0
    }

    public func isLastScene(sceneNumber: Int) -> Bool {
        return sceneNumber == appDescription.scenes.count - 1
    }

    public func loadCurrentScene() throws {
        do {
            _ = try sceneFactory.loadScene(description: getSceneDescription(sceneIndex: currentScene))
        } catch {
            throw error
        }
    }

    public func goToPreviousScene() throws {
        if !isFirstScene(sceneNumber: currentScene) {
            setCurrentScene(currentScene-1)
        }
        do {
            try loadCurrentScene()
        } catch {
            throw error
        }
    }

    public func goToNextScene() throws {
        if !isLastScene(sceneNumber: currentScene) {
            setCurrentScene(currentScene+1)
        }
        do {
            try loadCurrentScene()
        } catch {
            throw error
        }
    }

    public func goToScene(sceneId: String) throws {
        setCurrentScene(sceneId)
        do {
            try loadCurrentScene()
        } catch {
            throw error
        }
    }
}
