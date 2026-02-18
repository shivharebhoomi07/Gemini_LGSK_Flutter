# 🖥️ Liquid Galaxy Flutter: Virtual Rig Simulation Workflow

## 📋 Overview
This workflow provides a standardized protocol for testing the **App-Authoritative BLoC** and **Hybrid Sync Protocol** using a single laptop. Since Flutter does not render the world directly, we simulate the 3-screen or 5-screen rig using virtualized Google Earth instances.

---

## 🏗️ Step 1: Initialize the Virtual Cluster
Unlike web tabs, we must prepare the local environment to receive SSH/KML data.

* **Action**: Launch the **Liquid Galaxy Virtual Machine (LGVM)** or start multiple instances of Google Earth Pro on your desktop.
* **Architecture Note**: Ensure each instance is listening on a unique port if using a single OS, or use the standard port 22 if using a bridged VM.
* **Flutter Config**: Run the `lg-init` skill to set your `masterIp` to `127.0.0.1` (localhost) or your VM's internal IP.

---

## 📡 Step 2: Establish the App-to-Sim Connection
**Goal:** Verify the **SSH Handshake** from the Flutter Controller to the local simulator.

* **Action**: Run the Flutter app in **macOS/Windows Desktop mode** or an **Android Emulator**.
* **Handshake Check**: Use the "Connection" feature in your app to ping the local instances. 
* **Verification**: Check the Flutter console for `dartssh2: Connection Established` logs.



---

## 🛠️ Step 3: Verify the "Panoramic Handover"
This is the equivalent of the Web Kit's "Ball moving between screens" test.

* **Action**: Trigger a **`<gx:Tour>`** or a **Horizontal Orbit** from the Flutter Dashboard.
* **The "Handover" Test**: Observe the virtual instances. As the camera rotates, the view should transition seamlessly:
    * **Screen 1 (Left)**: Shows the trailing edge of the location.
    * **Screen 2 (Master)**: Shows the center-point.
    * **Screen 3 (Right)**: Shows the leading edge.
* **Sync Check**: If you trigger a "Fly-To," all virtual windows must initiate the move at the exact same millisecond.

---

## 🧐 Step 4: The Hybrid Sync Verification
**Goal:** Prove the **SFTP + KML Link** strategy works locally.

1. **SFTP Audit**: Check your local `temp/` or VM `/var/www/html/` folder. Did the Flutter app successfully upload the `kmls.txt` and the processed **Nano Banana Sprites**?
2. **KML Refresh**: Verify that the Master instance is successfully polling the link and updating the view without lag.

---

## 🎓 Educational Checkpoint
If the simulation fails to sync, the **Skeptical Mentor** will ask:
> *"If Screen 1 is moving but Screen 3 is static, is the issue in our BLoC state or our SFTP Slave-Injection loop? Walk me through the data path."*

---

## 🚀 Final Verification Checklist
- [ ] **Flutter Analyze**: 0 errors in the `core/services` layer.
- [ ] **Local Handshake**: SSH connection to `127.0.0.1` is successful.
- [ ] **Panoramic Alignment**: The `LookAt` heading is correctly offset across the virtual instances.
- [ ] **Wow Factor**: The cinematic movement is smooth across all simulated windows.