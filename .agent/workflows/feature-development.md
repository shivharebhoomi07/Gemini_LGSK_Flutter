# 🌊 Liquid Galaxy Feature Development Workflow

## 📋 Overview
This is the master agentic workflow for the **Gemini Summer of Code**. It orchestrates the end-to-end lifecycle of a Liquid Galaxy feature, ensuring architectural discipline and educational integrity through a 6-stage mandatory pipeline.

## ⛓️ The 6-Stage Mandatory Pipeline
The agent MUST strictly follow this sequence. Jumping stages is an automatic trigger for the **Skeptical Mentor**.

1.  **Initialize (`lg-init`)**: Verify environment and scaffold the Clean Architecture skeleton.
2.  **Brainstorm (`lg-brainstormer`)**: Define the "Wow Factor" and map ideas to BLoC events.
3.  **Plan (`lg-plan-writer`)**: Break the design into 5-10 minute atomic Flutter tasks.
4.  **Execute (`lg-exec`)**: Implement Dart code in batches with mandatory educational debriefs.
5.  **Review (`lg-code-reviewer`)**: Perform a professional OSS audit (linting, tests, architecture).
6.  **Quiz (`lg-quiz-master`)**: The "Grand Finale" to verify the student's conceptual mastery.

---

## 🚦 Phase 1: The Project Handshake (Init & Brainstorm)
**Goal:** Establish the technical foundation and creative vision.

* **Action:** Invoke `lg-init` to calibrate the Rig Topology (Screen count and Master IP).
* **Action:** Invoke `lg-brainstormer` to ensure the project utilized the 180-degree panoramic view effectively.
* **Constraint:** The workflow cannot proceed to planning until a `docs/plans/YYYY-MM-DD-design.md` file exists and is committed.

## 🛠️ Phase 2: The Engineering Loop (Plan & Execute)
**Goal:** Transform the blueprint into a production-grade Flutter codebase.

* **Action:** Invoke `lg-plan-writer` to generate the Implementation Matrix.
* **Verification:** The agent MUST conduct the **Educational Verification Phase** (The Quiz) before writing any code.
* **Action:** Invoke `lg-exec` to implementation the BLoC, Repository, and SSH logic.
* **Constraint:** Every batch of 2-3 tasks MUST end with a `flutter analyze` check and a git commit.

## 🧐 Phase 3: The Quality Gate (Review & Quiz)
**Goal:** Ensure the code is "Winner-Level" and the student has actually learned.

* **Action:** Invoke `lg-code-reviewer`. If the verdict is `REVISIONS NEEDED`, the workflow loops back to `lg-exec`.
* **Action:** Once `APPROVED`, trigger the `lg-quiz-master` for the TV-Show style finale.
* **Deliverable:** Generate the `docs/reviews/final-quiz-report.md` as the final graduation artifact.

---

## 🛡️ Global Workflow Guardrails
* **Silent Passenger Rule:** If the student remains inactive for 3 turns, the workflow halts and calls `lg-skeptical-mentor`.
* **Sync Law:** Any workflow that touches KML generation MUST verify the **Hybrid Sync Protocol** (Master Link + Slave Upload).
* **Documentation:** Every workflow stage MUST update the `docs/learning-journal.md`.