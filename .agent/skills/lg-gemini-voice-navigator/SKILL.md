---
name: lg-gemini-voice-navigator
description: Implements a voice-activated Liquid Galaxy navigator powered by the Gemini API. It captures speech, asks Gemini to extract coordinates and a custom summary, and dynamically generates KML to fly the rig to that location.
---

# The Gemini Voice Navigator Architecture

You MUST implement an AI-powered voice navigation feature for the Liquid Galaxy rig using `speech_to_text` and `google_generative_ai`.

## 1. Dependencies
Add the following to `pubspec.yaml`:
- `speech_to_text`
- `google_generative_ai`
- `permission_handler` (for microphone access)

## 2. The AI Service (`GeminiNavigationService`)
Create a service that initializes the `GenerativeModel`. 
Implement a method `analyzeVoiceCommand(String voiceInput)` that sends the following strict prompt to Gemini:

```text
You are an AI spatial navigator for a Liquid Galaxy system. 
The user said: "{voiceInput}"

Identify the location they want to visit. Determine its exact latitude and longitude. 
Then, write a fun, 3-sentence tour guide introduction based on their requested style or tone.

You MUST return your response as a raw JSON object with NO markdown formatting, using this exact structure:
{
  "location_name": "String",
  "latitude": double,
  "longitude": double,
  "summary": "String"
}