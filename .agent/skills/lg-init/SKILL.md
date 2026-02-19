# 🏗️ Liquid Galaxy Flutter Architect (lg-init)

## 📋 Description
This skill acts as the **Chief Architect** for the Liquid Galaxy Flutter Starter Kit. It transforms a raw Flutter environment into a specialized **Distributed Visualization Controller**. It enforces strict "Clean Architecture" standards, configures the "Hybrid Sync" network layer, and bootstraps the 6-stage agentic pipeline.

## ⚡ Trigger Logic
**Use this skill when:**
* A user starts a new project or asks to "initialize" the kit.
* The agent detects a missing or corrupted `lib/` folder structure.
* This is **Phase 1** of the mandatory pipeline: **Init** ➔ **Brainstorm** ➔ **Plan** ➔ **Execute** ➔ **Review** ➔ **Quiz**.

---

## ⚠️ PROMINENT GUARDRAIL: The Skeptical Mentor
The **Skeptical Mentor** (`../lg-skeptical-mentor/SKILL.md`) is **ACTIVE**.
You are **FORBIDDEN** from proceeding if the folder structure deviates by even one file.
* **Rejection Trigger:** SSH logic found inside a UI Widget (Presentation Layer).
* **Rejection Trigger:** Missing `features/connection` or `features/dashboard` modular separation.
* **Rejection Trigger:** Ignoring the "Hybrid Sync" protocol (Master + Slave injection).

---

## ⛓️ Phase 0: Environment Integrity
Before initialization, verify the foundation is solid.
1. **Git Check:** Is this a git repository? (`git status`).
2. **Origin Check:** Verify the user is working on a **Fork** of the Starter Kit, not the root.
3. **Flutter Health:** Confirm `flutter doctor` returns no critical errors. 
   * *Action:* If `pubspec.yaml` is missing, **STOP**.

---

## 🏁 Phase 1: Interactive Requirement Gathering
Before writing code, you **MUST** interview the user to configure the **Rig Topology**:

1. **Project Identity:** Name and Vision (e.g., "LG-Ocean-Cleanup").
2. **Rig Topology (Physical Cluster):**
   * **Screen Count:** (e.g., 3, 5, 7). *Crucial for the Slave Injection loop.*
   * **Master IP:** (e.g., `192.168.0.10`).
   * **SSH Port:** (Default: 22).
3. **Target Device:** Tablet (Landscape) or Phone (Portrait)?
   * *Impact:* Determines the `LayoutBuilder` strategy in `presentation/`.

---

## 🏗️ Phase 2: The "Golden Standard" Architecture
You must strictly enforce this **Feature-First Clean Architecture**. Delete any default boilerplate.

```text
/
├── .agent/                  # 🧠 Agent skills (The Brain)
├── assets/                  # 🎨 Resources (Must be in pubspec.yaml)
│   ├── images/              # logo.png
│   └── kmls/                # blank.kml, logo.kml
├── docs/                    # 📄 Architecture documentation
├── lib/
│   ├── core/                # ⚙️ The Engine (Shared across features)
│   │   ├── constants/       # app_constants.dart (IPs, Ports)
│   │   ├── failures/        # lg_exception.dart (Custom Error Handling)
│   │   ├── models/          # connection_params.dart (Data Models)
│   │   ├── services/        # ssh_service.dart (THE ONLY SSH ENTRY POINT)
│   │   ├── theme/           # app_theme.dart (Dark Mode for LG)
│   │   └── utils/           # kml_generator.dart (Orbit Math), geometry_helper.dart
│   ├── features/            # 🚀 Modular Business Logic
│   │   ├── connection/      # Feature 1: Handshake & Auth
│   │   │   ├── data/        # ConnectionRepository
│   │   │   └── presentation/# ConnectionBloc & UI
│   │   └── dashboard/       # Feature 2: Command Center
│   │       ├── data/        # DashboardRepository (Hybrid Sync Logic)
│   │       ├── domain/      # DashboardRepositoryInterface (Contract)
│   │       └── presentation/# DashboardBloc & Control Grid
│   └── main.dart            # 🏁 Dependency Injection (GetIt) & Entry
└── pubspec.yaml             # 📦 Dependencies: flutter_bloc, get_it, dartssh2, equatable
```

---

## ⚙️ Phase 3: Configuration Injection
Inject the user's answers into the Core Engine.

1. **`lib/core/constants/app_constants.dart`**
   * *Mandate:* Hardcode the `defaultIp` and `defaultScreens` variables with user input.
2. **`lib/core/services/ssh_service.dart`**
   * *Mandate:* Verify `dartssh2` is isolated here. NEVER let the UI import this file directly.

---

## 🎓 Phase 4: The 3 "Winner" Rules (Best Practices)
The student must acknowledge these rules before the pipeline continues:

* **The "Clean" Separation:** "Features are isolated. The Dashboard never talks to Connection directly; they share data via Core or GetIt. This makes your app scalable."
* **The Hybrid Sync Protocol:** "We do not trust loopbacks. We upload KML to Master (via Link) AND Slaves (via SFTP) simultaneously. This is 'Total Coverage'."
* **State Sovereignty:** "The BLoC is the single source of truth. The Rig is just a pixel display. If BLoC says 'Orbiting', the Rig must be orbiting."

---

## 🚀 Execution Script

* **Gather:** Ask Phase 1 questions.
* **Scaffold:** Build the `lib/core` and `lib/features` tree exactly as shown.
* **Audit:** Verify `pubspec.yaml` contains `flutter_bloc`, `get_it`, `dartssh2`, `equatable`.
* **Inject:** Update AppConstants with Rig IP/Screens.
* **Document:** Create `docs/project-overview.md`.
* **Handover:** Ask: *"Ready to design your first visualization?"* and trigger `lg-brainstormer`.
