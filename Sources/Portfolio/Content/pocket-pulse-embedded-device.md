---
title: Building POCKET-PULSE: Embedded Swift Communication Device
date: January 18, 2025
---

POCKET-PULSE is an open-source communication device that allows couples in long-distance relationships to send and receive emotional "pulses" through haptic feedback. Built with Embedded Swift on ESP32-C6 hardware, this project demonstrates the practical application of Swift in resource-constrained embedded systems.

## The Problem POCKET-PULSE Solves

Long-distance relationships often suffer from communication gaps. Traditional messaging feels impersonal and can be overwhelming. POCKET-PULSE provides a subtle, intimate way to send emotional signals that don't require immediate attention but maintain connection.

## How It Works

The device consists of two main components: a sender and a receiver. Each device connects to the other's pulse network and can send haptic feedback signals.

### Basic Pulse Communication

```swift
// Core pulse sending mechanism
struct PulseDevice {
    private var pulseQueue: [PulseMessage] = []
    private let vibrator: HapticMotor

    func sendPulse(intensity: PulseIntensity) {
        let pulse = PulseMessage(
            senderId: deviceId,
            timestamp: Date.now,
            intensity: intensity
        )

        // Send via available networks
        bluetoothManager.broadcastPulse(pulse)
        wifiManager.sendPulseToPartner(pulse)

        // Local haptic confirmation
        vibrator.vibrate(intensity.hapticPattern)
    }

    func receivePulse(_ pulse: PulseMessage) {
        // Queue pulse for processing
        pulseQueue.append(pulse)

        // Immediate haptic feedback
        vibrator.vibrate(pulse.intensity.hapticPattern)
    }
}
```

### Power Management

One of the biggest challenges in embedded systems is power consumption. POCKET-PULSE implements aggressive power management to achieve weeks of battery life.

```swift
actor PowerManager {
    enum PowerState {
        case active, idle, sleep, deepSleep
    }

    private var currentState = PowerState.active

    func transitionToSleep() {
        // Disable non-essential peripherals
        wifi.disable()
        bluetooth.setLowPowerMode()

        // Reduce CPU frequency
        cpu.setFrequency(.low)

        currentState = .sleep
    }

    func wakeForPulse() {
        // Quickly restore full functionality
        cpu.setFrequency(.high)
        bluetooth.enable()

        currentState = .active
    }
}
```

## Key Technical Challenges

### Memory Constraints

Embedded devices have limited RAM (512KB on ESP32-C6). POCKET-PULSE uses bit-packing and fixed-size buffers to minimize memory usage.

```swift
// Bit-packed pulse message to save memory
struct PulseMessage {
    // Pack multiple fields into a single UInt64
    private var packedData: UInt64

    init(senderId: UInt16, timestamp: UInt32, intensity: PulseIntensity) {
        packedData = (UInt64(senderId) << 48) |
                    (UInt64(timestamp) << 16) |
                    UInt64(intensity.rawValue)
    }

    var senderId: UInt16 { UInt16((packedData >> 48) & 0xFFFF) }
    var timestamp: UInt32 { UInt32((packedData >> 16) & 0xFFFFFFFF) }
    var intensity: PulseIntensity { PulseIntensity(rawValue: UInt8(packedData & 0xFF))! }
}
```

### Real-Time Responsiveness

For good user experience, pulses must be delivered with minimal latency. The device uses hardware interrupts and optimized message processing.

```swift
// Hardware interrupt for pulse button
func setupPulseButton() {
    let button = GPIO(pin: 0, mode: .input, pull: .up)

    button.onInterrupt(.falling) { [weak self] in
        self?.handlePulseButton()
    }
}

func handlePulseButton() {
    // Immediate haptic feedback
    vibrator.startPulse()

    // Queue pulse for transmission
    pulseManager.sendPulse(.medium)
}
```

## Connectivity Options

POCKET-PULSE supports multiple communication methods to ensure reliable pulse delivery:

### Direct Bluetooth
```swift
class BluetoothManager {
    func broadcastPulse(_ pulse: PulseMessage) {
        // Send to nearby devices
        let advertisement = BLEAdvertisement(pulseData: pulse.packedData)
        blePeripheral.startAdvertising(advertisement)
    }
}
```

### MQTT over Wi-Fi
```swift
class MQTTManager {
    func sendPulseToPartner(_ pulse: PulseMessage) {
        guard wifi.isConnected else { return }

        let topic = "pulse/\(partnerDeviceId)"
        mqttClient.publish(topic, payload: pulse.jsonData)
    }
}
```

## Why Swift for Embedded?

Swift's type safety and modern syntax make embedded development more reliable and maintainable:

- **Compile-time safety** prevents many runtime errors
- **Strong typing** eliminates common embedded bugs
- **ARC memory management** is more predictable than manual allocation
- **Modern concurrency** with async/await simplifies complex state machines

## Getting Started

To build your own POCKET-PULSE device:

1. **Hardware**: ESP32-C6 development board with vibration motor and battery
2. **Software**: Swift Embedded toolchain and POCKET-PULSE firmware
3. **Configuration**: Pair devices and set up communication channels

## Learn More

For the complete implementation with detailed setup instructions, networking protocols, and advanced features:

[🔗 View POCKET-PULSE on GitHub](https://github.com/mac9sb/pocket-pulse)

This project demonstrates how Swift can be successfully used in embedded systems to create meaningful, battery-efficient IoT devices that solve real human needs.