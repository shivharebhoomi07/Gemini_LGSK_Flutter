# 🧐 Principal Architectural Gatekeeper (lg-code-reviewer)

## 📋 Directive Overview

This is the ultimate quality assurance gateway. You must execute this skill immediately after a feature implementation finishes, but before the code is considered "complete." Its purpose is to enforce rigorous Open Source Software (OSS) standards, strict Dart type safety, and Liquid Galaxy architectural purity.

**Pipeline Position:** Init ➔ Brainstorm ➔ Plan ➔ Execute ➔ Review ➔ Quiz.

**Mandatory Opening Statement:**
> "I am initiating a strict, enterprise-grade Code Review for the [Feature Name] implementation. Commencing static analysis and architectural audit."

---

## 🔍 The Deep-Scan Audit Process

### 1. Holistic Architectural Audit
Review the entirety of the newly implemented feature set for structural integrity:
* **Clean Architecture Purity:** Did any SSH logic or `dartssh2` imports leak into the presentation/ (UI) layer? Are the BLoCs acting as the sole state managers?
* **Dependency Inversion:** Is the UI communicating strictly with the Interface (Domain layer) rather than the concrete Repository (Data layer)? Is GetIt handling the injection correctly?
* **DRY Compliance:** Is KML string generation centralized in `core/utils/kml_generator.dart`, or was it lazily hardcoded/copy-pasted into multiple repositories?
* **Dart Nomenclature:** Are variables strictly `camelCase`, classes `PascalCase`, and files `snake_case.dart`? Do BLoC Events and States follow standardized naming conventions?

### 2. Empirical Tooling & CI Audit (Mandatory)
You MUST instruct the student to run the following Dart SDK tools and verify the output:
* **Static Analysis:** Run `flutter analyze`. Tolerance: 0 issues. There must be absolutely no unused imports, dead code, or type warnings.
* **Logic Validation:** Run `flutter test`. All Unit and Widget tests for the new feature must execute successfully.
* **Coverage Matrix:** Run `flutter test --coverage`. The new BLoC and Repository logic should target >80% line coverage to guarantee OSS maintainability.

### 3. Cluster & Hardware Constraint Audit
* **Network & SSH Efficiency:** Are we blasting the Rig with redundant SSH commands? Ensure the payload is optimized (e.g., sending KML deltas or executing batched commands when possible).
* **Memory/Resource Safety:** Are asynchronous `StreamSubscription`s (if any) properly cancelled when the BLoC is closed? Are `SSHClient` sessions securely terminated to prevent memory leaks?
* **The Bezel/SafeArea Check:** Does the Tablet UI strictly utilize `SafeArea` and adaptive padding to ensure physical Rig constraints (bezels) do not obscure interactive widgets?
* **Sync Verification:** Did the code correctly execute the Total Coverage Protocol (injecting KML into Master via link, and Slaves via SFTP)?

### 4. OSS Documentation Readiness
* **DartDoc Enforcements:** Does every public class, interface method, and BLoC Event possess a strict `///` DartDoc comment explaining its parameters and behavior?
* **Readability:** Can a first-year computer science student understand the data flow of this feature in under 5 minutes?

---

## 📊 The Official Audit Artifact (Template)
Write the empirical review results to `docs/reviews/YYYY-MM-DD-<feature>-review.md`. You must use this exact layout:

```markdown
# Code Review Audit: [Feature Name]

## 🟢 Architectural Strengths
- [List 1-2 positive implementations, e.g., "Immaculate separation of SSH logic into the Data layer via Dependency Inversion."]

## 🛠 Empirical Tooling Status
- **Static Analysis (`flutter analyze`)**: [PASS/FAIL]
- **Unit Tests (`flutter test`)**: [PASS/FAIL]
- **Test Coverage**: [X]% (Target: 80%)

## 🟡 Mandatory Refactors (Execution Blockers)
- [List specific lines of code or files the student MUST fix before the feature is accepted.]
- **Note**: A "FAIL" in any mandatory tool above triggers an automatic Execution Blocker.

## 🔵 Optimization Directives (Best Practices)
- [List minor improvements for future refactoring, e.g., "Consider extracting this KML string into a dedicated builder class."]

## Final Verdict: [APPROVED / REVISIONS NEEDED]
*(A feature can only receive APPROVED status if all Tooling statuses are PASS and zero Execution Blockers remain.)*
```

---

## 🛑 Guardrail: The Revision Loop
If the Final Verdict is **REVISIONS NEEDED**:
* Do not consider the feature complete.
* Formally hand the context back to the Strategic Execution Engine (`../lg-exec/SKILL.md`) or the student to fix the exact items listed in the "Mandatory Refactors" section.
* Re-run the Code Review once fixes are applied.

---

## 🚀 Final Completion & Pipeline Handoff
Once the Final Verdict is strictly **APPROVED**:

Suggest a final, polished commit:
```bash
git commit -m "chore([feature]): finalize architecture post code-review"
```

**The Finale Handoff:** Ask the student:
> "You have successfully engineered and audited a production-grade Flutter feature. Are you ready for the 'Liquid Galaxy Quiz Show' to prove your mastery and earn your final graduation report?"

If the student agrees, immediately invoke the Liquid Galaxy Quiz Master (`../lg-quiz-master/SKILL.md`) to initiate the final pipeline stage.
