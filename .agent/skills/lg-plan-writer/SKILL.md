# 🗺️ Strategic Implementation Planner (`lg-plan-writer`)

## 📋 Directive Overview

Use this skill when a technical blueprint has been finalized in the Brainstorming phase. This skill translates abstract specifications into a rigorous, bite-sized Agile execution matrix specifically tailored for the **Liquid Galaxy Flutter Clean Architecture**.

**Pipeline Position:** `Init` ➔ `Brainstorm` ➔ **`Plan`** ➔ `Execute` ➔ `Review` ➔ `Quiz`

> 🚨 **CRITICAL GUARDRAIL: The Educational Verification Gate**
> 
> The `lg-skeptical-mentor` (`../lg-skeptical-mentor/SKILL.md`) is your pedagogical enforcer. You are strictly **FORBIDDEN** from moving to the execution phase (`lg-exec`) until the student successfully passes the *Educational Verification Phase* at the bottom of this document.

**Mandatory Opening Statement:**
> *"I am initializing the `lg-plan-writer` to construct your Agile implementation matrix."*

**Artifact Destination:**
Save plans exactly to `docs/plans/YYYY-MM-DD-<feature-name>-plan.md`.

---

## ⏱️ Micro-Task Granularity & Execution Flow

Do not create monolithic tasks. Every step must be an atomic, logical action taking no more than **5–10 minutes**.

* **The Clean Architecture Flow:** Always plan from the inside out: 
  `Domain (Contracts)` ➔ `Data (SSH Repositories)` ➔ `Presentation (BLoC → UI Widgets)`
* **Atomic Commits:** Every task must conclude with a Git commit.
* **Incremental Verification:** Validate Dart logic and BLoC states at every step before sending KML to the Rig.

---

## 📄 The Architectural Blueprint Header (Template)

Every plan document **MUST** begin with this exact structure:

```markdown
# [Feature Name] Implementation Matrix

**Feature Vision:** [One precise sentence defining the visual or functional goal]

**Architectural Paradigm:** [2–3 sentences defining the Clean Architecture flow, explicitly detailing how the App-Authoritative BLoC will manage the Rig's state]

**Core Dependencies:** [e.g., flutter_bloc, get_it, dartssh2]

**Pedagogical Goals:** [What advanced Dart/Flutter engineering principles will the student master during this build?]

---

## 🗺️ Execution Matrix
- [ ] Task 1: Domain — Define Interface Contract
- [ ] Task 2: Data — Implement Repository & SSH Logic
- [ ] Task 3: Presentation — Map BLoC Events & States
- [ ] Task 4: Presentation — Bind UI Widgets
```

---

## 🏗️ Task Anatomy (Template)

Every single task in the matrix must map directly to the `lib/core` and `lib/features` scaffolding.

**Task N: [Component or Logic Unit]**

**Target Vectors (Files):**
* **Create:** `lib/features/[feature_name]/domain/[feature]_repository_interface.dart`
* **Modify:** `lib/features/dashboard/presentation/pages/dashboard_page.dart`

**Step 1: Architectural Justification**
Briefly explain why this code belongs in this specific layer.  
*(Example: We define the interface in the Domain layer to invert dependencies, ensuring our UI never directly couples to the SSHService.)*

**Step 2: Interface / Contract Definition**
Write out the specific Dart class structure, BLoC Event, or KML/SSH payload.

```dart
// Example: lib/features/dashboard/data/dashboard_repository.dart
@override
Future<void> sendOrbitKml() async {
  // Hybrid Sync Implementation
}
```

**Step 3: Verification Protocol**
How does the student empirically verify this step succeeded?

* **Compiler Check:** Run `flutter clean` and `flutter pub get` to ensure no import errors.
* **Logic Check:** Add a `debugPrint` in the BLoC to verify Loading and Success states trigger correctly.
* **Rig Testing:** Deploy to the tablet, trigger the Event, and verify the Master Rig reflects the new KML.

**Step 4: State Preservation (Commit)**

```bash
git add .
git commit -m "feat([feature-layer]): [atomic description of the component]"
```

---

## ⚙️ Engineering Axioms to Enforce

* **The App-Authoritative Axiom:** State logic belongs exclusively in the Flutter BLoC. The Liquid Galaxy is a stateless rendering engine.
* **Layer Isolation (Separation of Concerns):** KML generation and SSH transmission stay strictly in `lib/features/*/data/` and `lib/core/services/ssh_service.dart`.
* **SOLID Dart:** Prevent God-classes. Ensure repositories are injected via GetIt (`sl()`).
* **The Synchronization Law:** Verify the Hybrid Sync protocol (Master `kmls.txt` link + Slave SFTP upload) for every new KML payload.

---

## 🎓 Educational Verification Phase (Mandatory Checkpoint)

Before writing a single line of implementation code, you **MUST** conduct a diagnostic dialogue with the student.

Ask the following questions:

1. **Architecture Check:** Why are we placing the `SSHService` call inside the Data Repository instead of directly inside the UI’s `onPressed` callback? What scalability issues arise otherwise?
2. **State Management Trade-offs:** Why does `flutter_bloc` improve UI responsiveness when waiting for the Rig?
3. **Synchronization Logic:** Explain the full data path: `Widget` ➔ `BLoC` ➔ `Repository` ➔ `SSH Hybrid Sync` ➔ `LG Screens`.
4. **SOLID Principles:** How does injecting the Repository via GetIt satisfy the Dependency Inversion principle?

**Action:**
* Do **NOT** proceed to `lg-exec` until answers are conceptually accurate.
* If failed, re-teach using Dart examples from this plan.

---

## 🚀 Execution Handoff

Once the markdown plan is saved and the Educational Verification Phase is passed:

> *"The Agile Implementation Matrix is locked and saved to `docs/plans/<filename>.md`."*
> *"Your architectural comprehension is verified."*
> *"I will now invoke the Strategic Execution Engine (`../lg-exec/SKILL.md`) to begin Task 1. Ready to write some Dart?"*
