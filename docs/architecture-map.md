# 🗺️ Liquid Galaxy Flutter: Architectural Master Map

## 📋 System Paradigm
This repository strictly enforces a **Layered Clean Architecture** combined with an **App-Authoritative BLoC Model**. 
The Flutter Controller (Tablet) acts as the sole "Brain" of the system. The Liquid Galaxy Rig (Google Earth) acts purely as a "Dumb Terminal" rendering engine.

---

## 🏗️ The Clean Architecture Layers
Every feature must be strictly decomposed into these three layers to ensure separation of concerns:

### 1. Presentation Layer (`lib/features/[feature_name]/presentation/`)
* **Widgets:** Pure UI components. They contain ZERO network or state logic.
* **BLoC (`flutter_bloc`):** The State Manager. It receives UI events, executes business logic via the Domain layer, and emits new UI states.

### 2. Domain Layer (`lib/features/[feature_name]/domain/`)
* **Entities:** Pure Dart data models.
* **Repository Interfaces:** Abstract contracts (e.g., `abstract class DashboardRepositoryInterface`). They define *what* the system does without exposing *how* it communicates with the Rig.

### 3. Data Layer (`lib/features/[feature_name]/data/`)
* **Repositories:** Concrete implementations of the Domain interfaces.
* **Services (`lib/core/services/ssh_service.dart`):** The exclusive home of the `dartssh2` client. This layer handles all raw SFTP uploads and KML string transmissions.

---

## 📡 The Hybrid Sync Protocol (Total Coverage)
To guarantee frame-perfect synchronization across 3, 5, or 7 Liquid Galaxy screens, all KML payloads must execute this two-step protocol:

1. **Slave Injection (SFTP):** Raw assets (e.g., Transparent AI Sprites, local KMLs) are uploaded directly to `/var/www/html/` on the Rig.
2. **Master Execution:** A network-linked `kmls.txt` file is updated on the Master machine via SSH to trigger the visual refresh across the cluster.