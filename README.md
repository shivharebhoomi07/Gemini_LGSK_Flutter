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
- [Architectural Principles](#-architectural-principles)
- [The Agentic AI Team](#-the-agentic-ai-team)
- [Core Features](#-core-features)
- [Getting Started](#-getting-started)
- [Repository Structure](#-repository-structure)
- [About the Author](#-about-the-author)

---

## 🛑 The Problem It Solves

Developing for a multi-screen **Liquid Galaxy** rig is unforgiving.  
A single malformed KML string or a blocking SSH call can cause frame drops, desync, or even freeze the physical rig.

The **Liquid Galaxy Agentic Starter Kit** removes this friction by providing a Clean Architecture–based Flutter foundation that abstracts hardware complexity and enforces disciplined execution.

**Core philosophy:**  
**Go slow, be steady, and never enter an unpredictable error state.**

---

## 🏗 System Architecture

This starter kit strictly follows **Clean Architecture** and the **Dependency Inversion Principle (S.O.L.I.D)**.  
The UI layer is completely decoupled from Liquid Galaxy hardware logic.

```mermaid
graph LR
    A["Flutter UI Widgets"] -->|"Events"| B["BLoC State Management"]
    B -->|"Interfaces"| C{"Domain Repositories"}
    C -->|"Dependency Injection (GetIt)"| D["SSH Network Service"]
    D -->|"KML / Commands"| E["Liquid Galaxy Rig"]

    style A fill:#42a5f5,stroke:#1e88e5,stroke-width:2px,color:#fff
    style B fill:#66bb6a,stroke:#43a047,stroke-width:2px,color:#fff
    style D fill:#ef5350,stroke:#e53935,stroke-width:2px,color:#fff
    style E fill:#ffa726,stroke:#fb8c00,stroke-width:2px,color:#fff
🧠 Architectural Principles
Dumb Views
UI widgets know nothing about IP addresses, SSH, or hardware state.

App-Authoritative State
The BLoC is the single source of truth; Liquid Galaxy screens reflect its state.

Hybrid Sync Protocol

Master node loads KMLs via hosted links

Slave nodes sync via secure file transfer

Ensures consistent visuals across all displays

🤖 The Agentic AI Team
This repository includes a Virtual AI Engineering Team inside the .agent/ folder, powered by Google Gemini.

Instead of a single chatbot, development is guided through a strict, multi-stage workflow.

Agent Pipeline
Stage	Agent	Responsibility
1️⃣	lg-init	Scaffolds feature folders with zero boilerplate
2️⃣	lg-brainstormer	Designs cinematic ideas for the panoramic rig
3️⃣	lg-plan-writer	Creates a step-by-step blueprint before coding
4️⃣	lg-exec	Implements the plan incrementally
5️⃣	lg-code-reviewer	Audits for UI freezes and memory issues
6️⃣	lg-quiz-master	Validates architectural understanding

🚨 Emergency Guardrail
A specialized skeptical mentor agent halts the workflow if:

Steps are skipped

SSH logic leaks into UI

Code is rushed without planning

This enforces architectural discipline throughout development.

✨ Core Features
🛡️ Robust SSH Client with graceful error handling

📍 Dynamic KML Engine (heavy computation off the UI thread)

🧹 Rig State Management (clear logos, wipe KMLs, reset view)

⚡ Hardware Controls (reboot, relaunch, power-off cluster)

🧠 Agent-driven development workflow

🚀 Getting Started
Prerequisites
Flutter SDK 3.19+

A physical or virtual Liquid Galaxy setup

Tablet or emulator

Quick Install
bash
Copy code
git clone https://github.com/shivharebhoomi07/Gemini_LGSK_Flutter-Wonder.git
cd Gemini_LGSK_Flutter-Wonder
flutter pub get
flutter run
Connection Guide
Launch the app

Open Connection Settings

Enter Master Node IP, Port (22), Username, Password

Connect and begin the experience

📁 Repository Structure
plaintext
Copy code
/
├── .agent/          # Agentic AI workflow & rules
├── assets/          # KMLs, logos, static assets
├── docs/            # Architecture and planning documents
├── lib/
│   ├── core/        # SSH services, utilities, constants
│   ├── features/    # Connection, Dashboard, etc.
│   └── main.dart    # App entry point & dependency injection
└── pubspec.yaml
👨‍💻 About the Author
Built by Bhoomi Shivhare
Submitted for the Gemini Summer of Code – Agentic Programming Contest

The skills-based agent structure was inspired by Mentor Vitor’s approach and thoughtfully adapted to support a disciplined, scalable Liquid Galaxy development workflow.

yaml
Copy code
