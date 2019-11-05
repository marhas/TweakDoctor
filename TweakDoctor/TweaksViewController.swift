//
//  TweaksViewController.swift
//  TweakDoctor
//
//  Created by Marcel Hasselaar on 2019-11-05.
//  Copyright © 2019 Marcel Hasselaar. All rights reserved.
//

import UIKit
import Mixpanel

class TweaksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConnectionMonitoring()
    }

    @IBAction private func connectToMixpanel(_ sender: Any) {
        guard let token = environmentSelector.selectedSegmentIndex == 0 ? UserDefaults.standard.string(forKey: "mixpanelStageToken") : UserDefaults.standard.string(forKey: "mixpanelProdToken") else {
            print("You need to enter the Mixpanel tokens in the System Preferences app")
            return
        }
        let mixpanel = Mixpanel.initialize(token: token)
        self.mixpanel = mixpanel
        mixpanel.loggingEnabled = true

        guard let tweakName = tweakNameTextField.text, !tweakName.isEmpty else { return }

        mixpanel.connectToMixpanel(reconnect: true)

        let defaultValue = defaultValueTextField.text ?? ""
        let tweak: TweakClusterType
        switch tweakTypeSelector.selectedSegmentIndex {
        case 1: tweak = Tweak<Int>(tweakName: tweakName, defaultValue: Int(defaultValue) ?? Int())
        case 2: tweak = Tweak<Double>(tweakName: tweakName, defaultValue: Double(defaultValue) ?? Double())
        case 3: tweak = Tweak<Bool>(tweakName: tweakName, defaultValue: Bool(defaultValue) ?? Bool())
        default: tweak = Tweak<String>(tweakName: tweakName, defaultValue: defaultValue)
        }

        MixpanelTweaks.resetTweakStore()
        let tweakStore = MixpanelTweaks.defaultStore
        tweakStore.addTweaks([tweak])
    }

    @IBAction private func environmentChanged(_ sender: UISegmentedControl) {
        connectToMixpanel(self)
    }

    private func setupConnectionMonitoring() {
        connectionMonitorTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.mixpanel?.connected == true {
                self.mixpanelConnectionStatusLabel.text = "Connected"
                self.mixpanelConnectionStatusLabel.textColor = .green
            } else {
                self.mixpanelConnectionStatusLabel.text = "Not connected"
                self.mixpanelConnectionStatusLabel.textColor = .red
            }
        }
    }

    @IBOutlet private var tweakNameTextField: UITextField!
    @IBOutlet private var tweakTypeSelector: UISegmentedControl!
    @IBOutlet private var defaultValueTextField: UITextField!
    @IBOutlet weak var environmentSelector: UISegmentedControl!
    @IBOutlet weak var mixpanelConnectionStatusLabel: UILabel!

    private var mixpanel: MixpanelInstance?
    private var mixpanelConnectionObservation: NSKeyValueObservation?
    private var connectionMonitorTimer: Timer?
    private var stdErrReadingTimer: Timer?
}
