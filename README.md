<div align="center">

# 🌌 Liquid Galaxy Agentic Starter Kit

**Build immersive, distributed 3D experiences without the boilerplate.**

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Gemini](https://img.shields.io/badge/Google%20Gemini-8E75B2?style=for-the-badge&logo=google&logoColor=white)](https://deepmind.google/technologies/gemini/)
[![Liquid Galaxy](https://img.shields.io/badge/Liquid_Galaxy-Open_Source-green?style=for-the-badge)](#)

*A robust, Clean Architecture Flutter controller powered by an integrated AI Engineering Team.*

</div>

---

## 📖 Table of Contents
- [The Problem It Solves](#-the-problem-it-solves)
- [System Architecture](#-system-architecture)
- [The Agentic AI Team (Secret Weapon)](#-the-agentic-ai-team-secret-weapon)
- [Core Features](#-core-features)
- [Getting Started](#-getting-started)
- [Repository Structure](#-repository-structure)
- [About the Author](#-about-the-author)

---

## 🛑 The Problem It Solves

Developing for a multi-screen **Liquid Galaxy** rig is notoriously unforgiving.  
A single malformed KML string or a blocking SSH command on the main thread can cause frame drops, network desyncs, or even freeze the physical rig.

**The Liquid Galaxy Agentic Starter Kit** eliminates this friction by providing a fortified, Clean Architecture–based Flutter foundation that abstracts away hardware-level complexity.

**Core philosophy:**  
**Go slow, be steady, and never enter an unpredictable error state.**

---

## 🏗 System Architecture

This starter kit strictly enforces **Clean Architecture** and the **Dependency Inversion Principle (S.O.L.I.D)**.  
The UI layer is completely decoupled from Liquid Galaxy hardware logic.

```mermaid
graph LR
    A[Flutter UI Widgets] -->|Events| B(BLoC State Management)
    B -->|Interfaces| C{Domain Repositories}
    C -->|GetIt Injection| D[SSH Network Service]
    D -->|KML / Commands| E[(Liquid Galaxy Rig)]

    style A fill:#42a5f5,stroke:#1e88e5,stroke-width:2px,color:#fff
    style B fill:#66bb6a,stroke:#43a047,stroke-width:2px,color:#fff
    style D fill:#ef5350,stroke:#e53935,stroke-width:2px,color:#fff
    style E fill:#ffa726,stroke:#fb8c00,stroke-width:2px,color:#fff
Architectural Principles
Dumb Views: UI widgets know nothing about IPs, SSH, or hardware state

App-Authoritative State: BLoC is the single source of truth

Hybrid Sync Protocol:

Master node loads KML via hosted links

Slave nodes sync via SFTP

Ensures total visual coverage across the rig

🤖 The Agentic AI Team (Secret Weapon)
This repository is more than a template — it includes a Virtual AI Engineering Team inside the .agent/ folder.

Powered by Google Gemini, the team consists of specialized agents that enforce a strict, error-resistant workflow.

🧠 Agent Pipeline
Stage	Agent	Responsibility
1️⃣	lg-init	Scaffolds feature folders with zero boilerplate
2️⃣	lg-brainstormer	Designs cinematic 3D ideas for the panoramic rig
3️⃣	lg-plan-writer	Drafts a markdown blueprint before coding
4️⃣	lg-exec	Implements the plan step-by-step in Dart
5️⃣	lg-code-reviewer	Audits for memory leaks and UI freezes
6️⃣	lg-quiz-master	Verifies architectural understanding

🚨 Emergency Brake: lg-skeptical-mentor
If a developer:

Skips steps

Rushes code

Mixes SSH logic into UI

This agent halts the workflow and enforces architectural discipline through review and questioning.

✨ Core Features
Out of the box, the Starter Kit supports all baseline Liquid Galaxy requirements:

🛡️ Bulletproof SSH Client (dartssh2 with timeouts & recovery)

📍 Dynamic KML Engine (heavy XML generated off the UI thread)

🧹 Rig State Management (clear logos, wipe KMLs, reset views)

⚡ Hardware Controls (reboot, relaunch, power-off cluster)

🧠 Agent-Guided Development Workflow

🚀 Getting Started
Prerequisites
Flutter SDK 3.19+

A physical Liquid Galaxy rig or virtual LG setup

Tablet or emulator

Quick Install
bash
Copy code
# Clone repository
git clone https://github.com/yourusername/Gemini_LGSK_Flutter-Wonder.git

# Enter directory
cd Gemini_LGSK_Flutter-Wonder

# Fetch dependencies
flutter pub get

# Run app
flutter run
Connection Guide
Launch the app on your tablet

Open Connection Settings

Enter Master Node IP, Port (22), Username, Password

Tap Connect and begin your cinematic tour

📁 Repository Structure
plaintext
Copy code
/
├── .agent/          # AI Engineering Team & workflow rules
├── assets/          # KMLs, logos, static resources
├── docs/            # Architecture diagrams & blueprints
├── lib/
│   ├── core/        # SSH, constants, utilities
│   ├── features/    # Connection, Dashboard, etc.
│   └── main.dart    # Entry point & dependency injection
└── pubspec.yaml
👨‍💻 About the Author
Built by Bhoomi Shivhare
Submitted for the Gemini Summer of Code – Agentic Programming Contest

The skills-based structure of this kit was inspired by Mentor Vitor’s approach and adapted thoughtfully to support a disciplined, scalable Liquid Galaxy development workflow.
