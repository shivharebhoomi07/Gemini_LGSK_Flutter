# 🗺️ LIQUID GALAXY STARTER KIT: FILE MANIFEST
**CRITICAL DIRECTIVE FOR ALL AI AGENTS:** This document defines the exact purpose of every core file in this Flutter project. You must use these files for their intended purposes. You are strictly forbidden from duplicating their logic, overwriting them, or bypassing them.





* **`lib/core/models/connection_params_model.dart`**
  * **Purpose:** The data entity that holds the dynamic Rig credentials (`ipAddress`, `port`, `username`, `password`). 
  * **Rule:** Never hardcode IP addresses. Always use this model.

## 🟢 2. THE CONNECTION FEATURE (`lib/features/connection/`)
*This feature handles the user interface and state for connecting to the Rig.*

* **`lib/features/connection/presentation/pages/connection_page.dart`**
  * **Purpose:** The UI screen (or Settings Drawer) containing text fields for IP, Port, Username, and Password. 
  * **Rule:** New features must assume this page exists and handles the connection beforehand.

* **`lib/features/connection/presentation/bloc/connection_bloc.dart`**
  * **Purpose:** Manages the global state (`Connected`, `Disconnected`, `Error`) of the Rig.

## 🔵 3. NEW FEATURE GENERATION RULES (`lib/features/[new_feature]/`)
*When instructed to build a new feature (e.g., "Compass", "VolcanoTracker"), you must scaffold it EXACTLY like this:*

* **`domain/entities/`**: Pure Dart models (e.g., `CompassDirection.dart`). No Flutter UI or SSH logic allowed here.
* **`domain/repositories/`**: Abstract interfaces defining what the feature can do.
* **`data/repositories/`**: The concrete implementation. **This is the ONLY place that should import `ssh_service.dart`.**
* **`presentation/bloc/`**: The state machine bridging the UI to the Data layer.
* **`presentation/pages/`**: The Flutter UI Widgets.

## 🟡 4. THE ENTRY POINT
* **`lib/main.dart`**
  * **Purpose:** App initialization.
  * **Rule:** When creating a new feature, you must register its BLoC and Repository here using the existing dependency injection (e.g., `MultiBlocProvider`).

  ## 🌐 External API Integration (Mandatory Contest Requirement)

To satisfy the core requirement of the Gemini Summer of Code Agentic Programming contest, this application MUST dynamically fetch data from an external API and render it onto the Liquid Galaxy screens using KML. 

The Chief Architect MUST implement a dynamic data fetch using the following generalized architecture:

1. **The Network Layer (`ApiDataService`):**
   - You must use the `http` package to fetch live data relevant to the project's specific domain (e.g., weather, live tracking, historical summaries).
   - **Default Fallback API:** If the user does not specify a particular API, default to using the free **Wikipedia REST API** (`https://en.wikipedia.org/api/rest_v1/page/summary/{poi_name}`) to fetch location summaries and images. 
   - **Constraint:** Prioritize public APIs that require no authentication/API keys to ensure the open-source demo runs frictionlessly.

2. **The Data Model (`PoiDetailsEntity`):**
   - Create a generic entity to hold the fetched data. Parse the JSON response to extract at least one piece of meaningful text (e.g., a summary, live coordinate, or statistic) and one relevant image URL.

3. **The KML Bridge (`KMLGenerator`):**
   - When generating the KML payload (like a `<gx:FlyTo>` or `<Point>`) for the selected entity, you MUST also generate a `<gx:BalloonStyle>` and a `<Placemark>` with a `<description>`.
   - Embed the fetched image and dynamic text inside a `<![CDATA[ ... ]]>` HTML block within the KML description. This forces the Liquid Galaxy Rig to render an informational UI bubble on the physical screens alongside the 3D rendering.

   ## ⚙️ Mandatory Agent Skills

The Chief Architect MUST automatically read and apply the following internal skills during the scaffolding and execution phases. Do not wait for the user to ask for these; they are required baseline functionality for all our Liquid Galaxy deployments.

* **Rig Control Integration:** You MUST execute the skill defined in `.agent/skills/lg-rig-controller/SKILL.md`. This requires you to build the `RigControlRepository` (using the exact hardcoded KML templates provided in that file) and a dedicated administrative `RigControlPage` UI to trigger those hardware commands.


## 🧰 Available Advanced Skills (Opt-In)

The Chief Architect has access to advanced modular skills. Do NOT implement these automatically unless the user explicitly requests them or asks for "Grand Prize Features."

* **Voice Navigation System (`.agent/skills/lg-gemini-voice-navigator/SKILL.md`):** A complex, Gemini-powered spatial voice controller. Requires `speech_to_text`, API key management, and microphone permissions.