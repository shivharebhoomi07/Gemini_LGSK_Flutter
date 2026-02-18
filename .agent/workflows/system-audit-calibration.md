# 🛠️ System Audit & Rig Calibration Workflow

## 📋 Overview
This workflow is the "Flight Mechanic" of the Agentic Pipeline. It is triggered when the `lg-exec` verification fails or when a student reports a connection blocker. It enforces a systematic audit of the **Dart-to-Rig SSH pipeline** and the **KML File System integrity**.

## ⛓️ The Calibration Chain
The agent must never "guess" why a connection failed. It must follow this immutable diagnostic chain:

1. **Environment Integrity Check (`lg-init`)**: Verify `pubspec.yaml` dependencies and Git status.
2. **Network Handshake**: Perform a low-level ping and SSH authentication test via `dartssh2`.
3. **Payload Sanitization**: Audit the KML generation logic for XML syntax errors before transmission.
4. **Hybrid Sync Verification**: Check if the Master `kmls.txt` and Slave SFTP directories are reachable.
5. **Mentor Intervention (`lg-skeptical-mentor`)**: If the student tries to "hack" the connection without fixing the root cause.

---

## 🏗️ Stage 1: The Hardware Handshake
**Goal:** Establish a verified persistent tunnel between the Flutter Controller and the LG Cluster.

* **Action:** Trigger an automated `flutter analyze` to ensure no breaking changes exist in the `core/services/` layer.
* **Action:** Execute a `remote_test` via the `SSHService` to confirm the Master IP provided in the Project Identity phase is active.
* **Constraint:** If the handshake fails, the Agent MUST ask the student for the Physical Rig's current status before retrying.

## 📡 Stage 2: KML & SFTP Synchronization Audit
**Goal:** Verify that the "Total Coverage Protocol" is functioning across the distributed cluster.

* **Action:** Audit the `lib/core/utils/kml_generator.dart` for valid `<LookAt>` or `<ScreenOverlay>` syntax.
* **Action:** Check for SFTP write permissions on the Rig's `/var/www/html/` directory.
* **Educational Bridge:** Explain the "App-Authoritative" model—remind the student that if the Rig shows old data, the Flutter State is likely out of sync with the SFTP cache.

## 🧐 Stage 3: The Skeptical Recovery
**Goal:** Prevent "Quick-Fix" engineering that introduces Technical Debt.

* **Action:** If the student suggests hardcoding an IP or bypassing the BLoC to "just make it work," the **Skeptical Mentor** MUST intervene.
* **Deliverable:** Log any temporary workarounds in `docs/tech-debt.md` for mandatory cleanup during the Review phase.

---

## 📝 Post-Calibration Protocol
* **Documentation:** Record the resolution in `docs/aimentor/YYYY-MM-DD-calibration-session.md`.
* **Verification:** Ensure the Rig is "Wowing" the room again before returning to the implementation pipeline.